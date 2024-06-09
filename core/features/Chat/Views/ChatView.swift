import SwiftUI

struct ChatView: View {
    static let tag: String? = "Chat"
    @ObservedObject var chatViewModel: ChatViewModel = .init()

    var body: some View {
        NavigationSplitView {
            VStack {
                List(chatViewModel.chatsModel.chats, id: \.id) { chat in
                    NavigationLink {
                        ChatMessageView(chatViewModel: chatViewModel)
                    } label: {
                        Text("\(chat.login_name ?? "")")
                    }
                }
            }
        } detail: {
            Text("Select a chatroom")
        }.task {
            chatViewModel.connect()
        }.badge(0)
    }
}

struct ChatView_Preview: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
