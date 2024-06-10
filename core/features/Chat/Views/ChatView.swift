import SwiftUI

struct ChatView: View {
    static let tag: String? = "Chat"
    @ObservedObject var chatViewModel: ChatViewModel = .init()

    var body: some View {
        NavigationSplitView {
            VStack {
                List(chatViewModel.chatsModel.chats, id: \.id) { chat in
                    NavigationLink {
                        ChatMessageView(chatViewModel: chatViewModel, selectedChat: chat)
                    } label: {
                        Text(chat.monitor_hash)
                    }
                }
            }
        } detail: {
            Text("Select a chatroom")
        }.task {
            chatViewModel.chatsModel.setChats(chats: [])
            chatViewModel.connect()
        }
        .alert(isPresented: $chatViewModel.showAlert) {
            Alert(
                title: Text("Login Error"),
                message: Text(chatViewModel.message)
            )
        }.navigationTitle("Chats")
        .onDisappear {
            chatViewModel.disconnect()
        }.badge(0)
        
    }
}

struct ChatView_Preview: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
