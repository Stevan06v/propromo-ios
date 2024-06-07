import Alamofire
import Foundation
import Starscream

struct ChatLoginRequest: Encodable {
    let email: String
    let password: String
    let monitor_id: String
}

let url = "propromo-chat.deno.dev" // production URL: https://propromo-chat.deno.dev

class ChatService {
    var webSocketManager: WebSocketManager?
    var monitorId = ""

    public var onMessage: ((_ message: ChatMessage, _ monitorId: String) -> Void)?

    func loginAndConnect(loginRequest: ChatLoginRequest, completion: @escaping (Result<[ChatMessage], Error>) -> Void) { // returns token for chat
        monitorId = loginRequest.monitor_id

        // let loginURL = URLRequest(url: URL(string: "https://\(url)/login")!, cachePolicy: .reloadIgnoringLocalCacheData) // wrong type

        let loginURL = URL(string: "https://\(url)/login")!
        let headers: HTTPHeaders = [
            "Cache-Control": "no-cache",
        ]

        AF.request(loginURL,
                   method: .post,
                   parameters: loginRequest, // body as json
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

            self.webSocketManager = WebSocketManager(monitorId: loginRequest.monitor_id, token: responseString) { message, monitorId in
                print("Received message: \(message)")
                self.onMessage!(message, monitorId)
            }
            self.webSocketManager?.connect()

            self.webSocketManager?.onConnected = {
                completion(.success([])) // messages are sent in multiple chuncks and not one, meaning the chats have to be updated in .text on didReceive
            }
            self.webSocketManager?.onError = { error in
                let errorFallback = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Something went wrong."])
                completion(.failure(error ?? errorFallback))
            }
        }
    }

    func sendMessage(_ message: String) {
        webSocketManager?.sendMessage(message)
    }

    func disconnect() {
        webSocketManager?.disconnect()
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

        urlRequest = URLRequest(url: URL(string: "ws://\(url)/chat/\(self.monitorId)?auth=\(self.token)")!)
        urlRequest.timeoutInterval = 5
        webSocket = Starscream.WebSocket(request: urlRequest)

        super.init()
        webSocket.delegate = self
    }

    init(monitorId: String, token: String, onMessageReceived: @escaping (ChatMessage, String) -> Void) {
        self.monitorId = monitorId
        self.token = token
        self.onMessageReceived = onMessageReceived

        urlRequest = URLRequest(url: URL(string: "wss://\(url)/chat/\(self.monitorId)?auth=\(self.token)")!)
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
