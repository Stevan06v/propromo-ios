import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @AppStorage("USER_KEY") var email: String = ""
    @AppStorage("USER_PASSWORD") var password: String = ""

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

    public func connect() {
        let loginRequest = ChatLoginRequest(email: email, password: password)
        chatService.loginAndConnect(loginRequest: loginRequest) { result in
            switch result {
            case let .success(response):
                for monitor in self.chatService.getMonitors() {
                    let monitorHash = monitor.key
                    let monitorBody = monitor.value

                    if let existingChatIndex = self.chatsModel.chats.firstIndex(where: { $0.id == monitorHash }) {
                        var updatedChats = self.chatsModel.chats
                        updatedChats[existingChatIndex].setMessages(messages: response)
                        self.chatsModel.setChats(chats: updatedChats)
                    } else {
                        let chat = Chat(
                            id: monitorHash,
                            monitor: monitorBody
                        )
                        var currentChats = self.chatsModel.getChats()
                        currentChats.append(chat)
                        self.chatsModel.setChats(chats: currentChats)
                    }
                }
            case let .failure(error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }

    public func disconnect() {
        for monitorId in chatService.getMonitorIds() {
            chatService.disconnect(from: monitorId)
        }
    }

    public func sendMessage(_ message: String, to monitor_hash: String) {
        chatService.sendMessage(message, to: monitor_hash)
    }

    func updateChatWithNewMessage(_ message: ChatMessage, monitor_hash: String) {
        guard let chatIndex = chatsModel.chats.firstIndex(where: { $0.id == monitor_hash }) else {
            print("no chat with correct monitorHash (\(monitor_hash)) found")
            print("failed to add '\(message)' to chat")
            return
        }

        var updatedChats = chatsModel.chats
        var updatedChat = updatedChats[chatIndex]
        updatedChat.setMessages(messages: (updatedChat.messages ?? []) + [message])
        updatedChats[chatIndex] = updatedChat

        chatsModel.setChats(chats: updatedChats)
        print("chat messages updated")
        print("chat count", chatsModel.chats.endIndex)
    }
}
