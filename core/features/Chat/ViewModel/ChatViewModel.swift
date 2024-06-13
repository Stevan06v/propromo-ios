import Foundation
import SwiftUI
import UserNotifications

class ChatViewModel: ObservableObject {
    @AppStorage("USER_KEY") var email: String = ""
    @AppStorage("USER_PASSWORD") var password: String = ""

    @Published public var showAlert: Bool = false
    @Published public var message: String = ""

    @Published public var chatsModel: ChatModel = .init()

    let chatService = ChatService()

    init() {
        chatService.onMessage = { message, monitorId in
            if Environment.isDebug { print("updating chat messages...") }
            self.updateChatWithNewMessage(message, monitor_hash: monitorId)
        }

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            } else if granted {
                print("Notification permission granted")
            }
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
                if Environment.isDebug { print(error) }

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
            if Environment.isDebug { print("failed to add '\(message)' to chat. no chat with correct monitorHash (\(monitor_hash)) found") }
            return
        }

        var updatedChats = chatsModel.chats
        var updatedChat = updatedChats[chatIndex]
        updatedChat.setMessages(messages: (updatedChat.messages ?? []) + [message])
        updatedChats[chatIndex] = updatedChat

        chatsModel.setChats(chats: updatedChats)

        if message.email != email {
            let content = UNMutableNotificationContent()
            content.title = "New Message from \(String(describing: message.email)) in \(String(describing: updatedChat.title))"
            content.body = message.text ?? "no message body..."
            content.sound = UNNotificationSound.default

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error creating notification: \(error.localizedDescription)")
                } else {
                    print("Notification created successfully")
                }
            }
        }

        // if (Environment.isDebug) { print("chat messages updated") }
        // if (Environment.isDebug) { print("chat count", chatsModel.chats.endIndex) }
    }
}
