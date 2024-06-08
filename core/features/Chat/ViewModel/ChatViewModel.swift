import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @AppStorage("USER_KEY") var userKey: String = ""

    @Published public var showAlert: Bool = false
    @Published public var message: String = ""

    @Published public var chatsModel: ChatModel = .init()

    let chatService = ChatService()

    init() {
        chatService.onMessage = { message, monitorId in
            print("updating chat messages ...")
            self.updateChatWithNewMessage(message, monitor_hash: monitorId)
        }
    }

    public func connect(monitor_id: String) {
        let loginRequest = ChatLoginRequest(email: "username@domain.tld", password: "password", monitor_id: "$2y$12$W3pHWdAtePn1wjCm4.t4xO9lY9jOcu8/5SC0bDEsaAfSB8pKA5k.K")
        chatService.loginAndConnect(loginRequest: loginRequest) { result in
            switch result {
            case let .success(response):
                do {
                    let chat = Chat(id: loginRequest.monitor_id, monitor_hash: loginRequest.monitor_id, login_name: loginRequest.email, short_description: "", messages: response)
                    var currentChats = self.chatsModel.getChats()
                    currentChats.append(chat)
                    self.chatsModel.setChats(chats: currentChats)
                }
            case let .failure(error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }

    public func sendMessage(_ message: String) {
        chatService.sendMessage(message)
    }

    func updateChatWithNewMessage(_ message: ChatMessage, monitor_hash: String) {
        if var chat = chatsModel.chats.first(where: { $0.monitor_hash == monitor_hash }) {
            print("chat to update: \(chat)")

            chat.setMessages(messages: chat.messages ?? [] + [message])
            chatsModel.setChats(chats: chatsModel.chats)
            print("chat messages updated")
            print(chatsModel.chats)
        } else {
            print("no chat with correct monitor_hash (\(monitor_hash)) found")
            print("failed to add '\(message)' to chat")
        }
    }
}
