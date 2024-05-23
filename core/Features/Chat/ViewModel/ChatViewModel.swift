import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @AppStorage("USER_KEY") var userKey: String = ""
    
    @Published public var showAlert: Bool = false
    @Published public var message: String = ""
    
    @Published public var chatsModel: ChatModel = ChatModel()
    
    let chatService = ChatService()
    
    init() {
        chatService.onMessage = { message, monitorId in
            print("updating chat messages ...")
            self.updateChatWithNewMessage(message, monitor_hash: monitorId)
        }
    }

    public func connect(password: String, monitor_id: String) {
        let loginRequest = ChatLoginRequest(email: "j.froe@gmx.at", password: "password", monitor_id: "w32tgse")
        chatService.loginAndConnect(loginRequest: loginRequest) { result in
            switch result {
            case .success(let response):
                do {
                    let chat = Chat(id: loginRequest.monitor_id, monitor_hash: loginRequest.monitor_id, login_name: loginRequest.email, short_description: "", messages: response)
                    var currentChats = self.chatsModel.getChats()
                    currentChats.append(chat)
                    self.chatsModel.setChats(chats: currentChats)
                }
            case .failure(let error):
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
            self.chatsModel.setChats(chats: self.chatsModel.chats)
            print("chat messages updated")
            print(self.chatsModel.chats)
        }
    }
}
