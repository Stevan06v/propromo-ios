import Alamofire
import Foundation
import Starscream

struct ChatLoginRequest: Encodable {
    let email: String
    let password: String
}

struct ChatBody: Decodable {
    let team: String
    let type: String
    let title: String
    let description: String
    let isPublic: Bool
    let createdAt: Date
    let updatedAt: Date
    let projectUrl: String
}

struct ChatInfo: Decodable {
    private(set) var monitor_hash: String
    private(set) var organization_name: String
    private(set) var type: String
    private(set) var title: String
    private(set) var short_description: String
    private(set) var `public`: Bool
    private(set) var created_at: String
    private(set) var updated_at: String
    private(set) var project_url: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        monitor_hash = try container.decode(String.self, forKey: .monitor_hash)
        organization_name = try container.decode(String.self, forKey: .organization_name)
        type = try container.decode(String.self, forKey: .type)
        title = try container.decode(String.self, forKey: .title)
        short_description = try container.decode(String.self, forKey: .short_description)
        `public` = try container.decode(Bool.self, forKey: .public)
        created_at = try container.decode(String.self, forKey: .created_at)
        updated_at = try container.decode(String.self, forKey: .updated_at)
        project_url = try container.decode(String.self, forKey: .project_url)
    }

    enum CodingKeys: String, CodingKey {
        case monitor_hash
        case organization_name
        case type
        case title
        case short_description
        case `public`
        case created_at
        case updated_at
        case project_url
    }
}

struct ResponseChats: Decodable {
    let token: String
    let chats: [ChatInfo]
}

let url = "propromo-chat.deno.dev" // 127.0.0.1:6969, production URL: chat-app-latest-m6ht.onrender.com | propromo-chat.deno.dev

class ChatService {
    var webSocketManagers: [String: WebSocketManager] = [:]
    var chats: [String: ChatBody] = [:]

    public var onMessage: ((_ message: ChatMessage, _ monitorId: String) -> Void)?

    func loginAndConnect(loginRequest: ChatLoginRequest, completion: @escaping (Result<[ChatMessage], Error>) -> Void) { // returns token for chat
        // let loginURL = URLRequest(url: URL(string: "https://\(url)/login")!, cachePolicy: .reloadIgnoringLocalCacheData) // wrong type

        let loginURL = URL(string: "https://\(url)/login")! // TODO, remove monitor_id from req obj and load all chats that login returns in .chats
        let headers: HTTPHeaders = [
            "Cache-Control": "no-cache",
        ]

        print(loginRequest)

        AF.request(loginURL,
                   method: .post,
                   parameters: loginRequest, // , body as json
                   encoder: JSONParameterEncoder.default,
                   headers: headers).response { response in
            if let error = response.error {
                print(error)
                completion(.failure(error))
                return
            }

            guard let responseData = response.data else {
                let error = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }

            guard let responseString = String(data: responseData, encoding: .utf8) else {
                let error = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data could not be converted to a string"])
                completion(.failure(error))
                return
            }

            guard let statusCode = response.response?.statusCode, (200 ..< 300) ~= statusCode else {
                let error = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not login to the specified monitor. (response of server: \(responseString))"])
                completion(.failure(error))
                return
            }

            do {
                let jsonResponseBody = try JSONDecoder().decode(ResponseChats.self, from: responseData)
                let token = jsonResponseBody.token
                let chats = jsonResponseBody.chats

                for chat in chats {
                    let webSocketManager = WebSocketManager(monitorId: chat.monitor_hash, token: token) { message, monitor_hash in
                        print("Received message: \(message)")
                        self.onMessage?(message, monitor_hash)
                    }

                    webSocketManager.connect()

                    webSocketManager.onConnected = {
                        completion(.success([])) // messages are sent in multiple chuncks and not one, meaning the chats have to be updated in .text on didReceive
                    }
                    webSocketManager.onError = { error in
                        let errorFallback = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Something went wrong."])
                        completion(.failure(error ?? errorFallback))
                    }

                    self.webSocketManagers[chat.monitor_hash] = webSocketManager

                    let formatter = ISO8601DateFormatter()
                    let created_at = formatter.date(from: chat.created_at)
                    let updated_at = formatter.date(from: chat.updated_at)

                    self.chats[chat.monitor_hash] = ChatBody(
                        team: chat.organization_name,
                        type: chat.type,
                        title: chat.title,
                        description: chat.short_description,
                        isPublic: chat.public,
                        createdAt: created_at ?? Date(),
                        updatedAt: updated_at ?? Date(),
                        projectUrl: chat.project_url
                    )
                }

                completion(.success([]))
            } catch {
                let error = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON response"])
                completion(.failure(error))
            }
        }
    }

    func sendMessage(_ message: String, to monitorId: String) {
        if let webSocketManager = webSocketManagers[monitorId] {
            webSocketManager.sendMessage(message)
        }
    }

    func disconnect(from monitorId: String) {
        if let webSocketManager = webSocketManagers[monitorId] {
            webSocketManager.disconnect()
        }
    }

    func getMonitorIds() -> [String] {
        return Array(webSocketManagers.keys)
    }

    func getMonitors() -> [String: ChatBody] {
        return chats
    }
}

class WebSocketManager: NSObject, WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client _: Starscream.WebSocketClient) { // self.webSocket.onEvent = { event in switch event {}
        switch event {
        case let .connected(headers):
            isConnected = true
            print("websocket is connected: \(headers)")
            onConnected?()
        case let .disconnected(reason, code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case let .text(string):
            print("Received text: \(string)")

            if let data = string.data(using: .utf8) {
                let decoder = JSONDecoder()
                if let message = try? decoder.decode(ChatMessage.self, from: data) {
                    print("appending message to chat")
                    messages.append(message)
                    print("messages: \(messages)")
                    onMessageReceived?(message, monitorId)
                }
            }
        case let .binary(data):
            print("Received data: \(data.count)")
        case .ping:
            break
        case .pong:
            break
        case .viabilityChanged:
            break
        case .reconnectSuggested:
            break
        case .cancelled:
            isConnected = false
        case let .error(error):
            isConnected = false
            handleError(error)
            onError?(error)
        case .peerClosed:
            break
        }
    }

    var onError: ((Error?) -> Void)?
    var onConnected: (() -> Void)?
    var onMessageReceived: ((ChatMessage, String) -> Void)?

    var urlRequest: URLRequest
    var webSocket: Starscream.WebSocket
    var monitorId: String
    var token: String

    var messages: [ChatMessage] = []
    var isConnected: Bool = false

    init(monitorId: String, token: String) {
        self.monitorId = monitorId
        self.token = token

        let encodedMonitorId = self.monitorId.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        urlRequest = URLRequest(url: URL(string: "wss://\(url)/chat/\(encodedMonitorId)?auth=\(self.token)")!)
        urlRequest.timeoutInterval = 5
        webSocket = Starscream.WebSocket(request: urlRequest)

        super.init()
        webSocket.delegate = self
    }

    init(monitorId: String, token: String, onMessageReceived: @escaping (ChatMessage, String) -> Void) {
        self.monitorId = monitorId
        self.token = token
        self.onMessageReceived = onMessageReceived

        let encodedMonitorId = self.monitorId.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        urlRequest = URLRequest(url: URL(string: "wss://\(url)/chat/\(encodedMonitorId)?auth=\(self.token)")!)
        urlRequest.timeoutInterval = 5
        webSocket = Starscream.WebSocket(request: urlRequest)

        super.init()
        webSocket.delegate = self
    }

    func connect() {
        webSocket.connect()
    }

    func disconnect() {
        webSocket.disconnect()
    }

    func sendMessage(_ message: String) {
        if isConnected {
            webSocket.write(string: message)
            // INFO: message is persisted in .text, because every message is coming back from the server with an id and a timestamp
        }
    }

    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
}
