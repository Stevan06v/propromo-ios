import SwiftUI

struct ChatsView: View {
    static let tag: String? = "Chat"
    @ObservedObject var chatViewModel: ChatViewModel = .init()

    var body: some View {
        NavigationSplitView {
            if chatViewModel.chatsModel.chats.isEmpty {
                VStack {
                    Text("No chats available.")
                        .foregroundColor(.gray)
                    Text("You do not have any monitors.")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .navigationTitle("Chats")
                .padding()
            } else {
                VStack {
                    List(chatViewModel.chatsModel.chats, id: \.id) { chat in
                        NavigationLink {
                            ChatMessagesView(chatViewModel: chatViewModel, selectedChat: chat)
                        } label: {
                            Text(chat.title ?? chat.id)
                        }
                    }
                }.navigationTitle("Chats")
            }
        } detail: {
            Text("Select a chatroom")
        }
        .task {
            chatViewModel.chatsModel.setChats(chats: [])
            chatViewModel.connect()
        }
        .alert(isPresented: $chatViewModel.showAlert) {
            Alert(
                title: Text("Login Error"),
                message: Text(chatViewModel.message)
            )
        }
        .onDisappear {
            chatViewModel.disconnect()
        }.badge(0)
    }
}

struct ChatsView_Preview: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
