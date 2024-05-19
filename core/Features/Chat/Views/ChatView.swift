import SwiftUI

struct ChatView: View {
    static let tag: String? = "Chat"
    @ObservedObject var chatViewModel: ChatViewModel = ChatViewModel()
    
    var body: some View {
        NavigationSplitView {
            List(chatViewModel.chatsModel.chats, id: \.id){ chat in
                NavigationLink { // detail
                    Text("\(chat.monitor_hash)")
                } label: { // summary
                    Text("\(chat.login_name ?? "")")
                }
            }
        } detail: {
            Text("Select a chatroom")
        }.task {
            chatViewModel.connect()
        }
    }
}
