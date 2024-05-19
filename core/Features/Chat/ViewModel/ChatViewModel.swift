import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @AppStorage("USER_KEY") var userKey: String = ""
    
    // alerts
    @Published public var showAlert: Bool = false
    @Published public var message: String = ""
    @Published public var chatsModel: ChatModel = ChatModel()
    
    public func connect() {
        let loginRequest = ChatLoginRequest(email: self.userKey, password: "", monitorId: "")
        ChatService().loginAndConnect(loginRequest: loginRequest) { result in
            switch result {
            case .success(let response):
                do {
                    // let decoder = JSONDecoder()
                    // let chatMessages = try decoder.decode([ChatMessage].self, from: response)

                    let chat = Chat(id: loginRequest.monitorId, monitor_hash: loginRequest.monitorId, login_name: loginRequest.email, short_description: "", messages: response)
                    var currentChats = self.chatsModel.getChats()
                    currentChats.append(chat)
                    self.chatsModel.setChats(chats: currentChats)
                } // catch {
                  //  print("Error decoding JSON: \(error.localizedDescription)")
                //}
            case .failure(let error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }
}
