import Alamofire
import Foundation
import Starscream

/* SETTINGS */
let useSecureProtocol = true
let sStandsForSecure = useSecureProtocol ? "s" : ""
let chatServerUrl = useSecureProtocol ? "propromo-chat.deno.dev" : "127.0.0.1:6969" // fallback: chat-app-latest-m6ht.onrender.com

/* CHAT */
class ChatService {
    var webSocketManagers: [String: WebSocketManager] = [:]
    var chats: [String: ChatBody] = [:]

    public var onMessage: ((_ message: ChatMessage, _ monitorId: String) -> Void)?

    /**
     Returns a token and chats. The token can be used to send or receive to or from any chat of the returned chats, the chats the user has access to.
     */
    func loginAndConnect(loginRequest: ChatLoginRequest, completion: @escaping (Result<[ChatMessage], Error>) -> Void) {
        // let loginURL = URLRequest(url: URL(string: "https://\(url)/login")!, cachePolicy: .reloadIgnoringLocalCacheData) // wrong type
        let loginURL = URL(string: "http\(sStandsForSecure)://\(chatServerUrl)/login")!

        let headers: HTTPHeaders = [
            "Cache-Control": "no-cache",
        ]

        if Environment.isDebug { print("chatLoginRequest:", loginRequest) }

        AF.request(loginURL,
                   method: .post,
                   parameters: loginRequest, // , body as json
                   encoder: JSONParameterEncoder.default,
                   headers: headers).response { response in
            if let error = response.error {
                if Environment.isDebug { print("Request Error: \(error)") }
                completion(.failure(error))
                return
            }

            guard let responseData = response.data else {
                let error = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response is empty."])
                if Environment.isDebug { print("Response data is nil.") }
                completion(.failure(error))
                return
            }

            guard let responseString = String(data: responseData, encoding: .utf8) else {
                let error = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data could not be converted to a string."])
                if Environment.isDebug { print("Response data could not be converted to a string.") }
                completion(.failure(error))
                return
            }

            guard let statusCode = response.response?.statusCode, (200 ..< 300) ~= statusCode else {
                let error = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not login to the specified monitor."])
                if Environment.isDebug { print("Could not login to the specified monitor. (response of server: \(responseString))") }
                completion(.failure(error))
                return
            }

            do {
                let jsonResponseBody = try JSONDecoder().decode(ChatLoginResponse.self, from: responseData)
                let token = jsonResponseBody.token
                let chats = jsonResponseBody.chats

                for chat in chats {
                    let webSocketManager = WebSocketManager(monitorId: chat.monitor_hash, token: token) { message, monitor_hash in
                        if Environment.isDebug { print("Received message: \(String(describing: message.text))") }
                        self.onMessage?(message, monitor_hash)
                    }

                    webSocketManager.connect()

                    // INFO: messages are sent in multiple chuncks and not one, meaning the chats have to be updated in .text on didReceive
                    webSocketManager.onConnected = {
                        self.webSocketManagers[chat.monitor_hash] = webSocketManager

                        let formatter = ISO8601DateFormatter()
                        let created_at = formatter.date(from: chat.created_at ?? Date().ISO8601Format())
                        let updated_at = formatter.date(from: chat.updated_at ?? Date().ISO8601Format())

                        self.chats[chat.monitor_hash] = ChatBody(
                            team: chat.organization_name ?? "",
                            type: chat.type ?? "",
                            title: chat.title ?? "",
                            description: chat.short_description ?? "",
                            isPublic: chat.public ?? false,
                            createdAt: created_at ?? Date(),
                            updatedAt: updated_at ?? Date(),
                            projectUrl: chat.project_url ?? ""
                        )

                        completion(.success([]))
                    }
                    webSocketManager.onError = { error in
                        let errorFallback = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Something went wrong."])
                        completion(.failure(error ?? errorFallback))
                    }
                }

                completion(.success([]))
            } catch {
                if Environment.isDebug { print("Failed to parse JSON response", error, responseString) }

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
    // self.webSocket.onEvent = { event in switch event {}
    func didReceive(event: Starscream.WebSocketEvent, client _: Starscream.WebSocketClient) {
        switch event {
        case let .connected(headers):
            isConnected = true
            onConnected?()
            if Environment.isDebug { print("websocket is connected (headers: \(headers))") }
        case let .disconnected(reason, code):
            isConnected = false
            if Environment.isDebug { print("websocket disconnected because '\(reason)' (code: \(code))") }
        case let .text(string):
            if Environment.isDebug { print("Received text: \(string)") }

            if let data = string.data(using: .utf8) {
                let decoder = JSONDecoder()
                if let message = try? decoder.decode(ChatMessage.self, from: data) {
                    if Environment.isDebug { print("appending message to chat...") }
                    messages.append(message)
                    onMessageReceived?(message, monitorId)
                    // if (Environment.isDebug) { print("messages: \(messages)") }
                }
            }
        case .binary:
            // if (Environment.isDebug) { print("Received data: \(data.count)") }
            break
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
        urlRequest = URLRequest(url: URL(string: "ws\(sStandsForSecure)://\(chatServerUrl)/chat/\(encodedMonitorId)?auth=\(self.token)")!)
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
        urlRequest = URLRequest(url: URL(string: "ws\(sStandsForSecure)://\(chatServerUrl)/chat/\(encodedMonitorId)?auth=\(self.token)")!)
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

    // INFO: message is persisted in .text, because every message is coming back from the server with an id and a timestamp
    func sendMessage(_ message: String) {
        if isConnected {
            webSocket.write(string: message)
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
