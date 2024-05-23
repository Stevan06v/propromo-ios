import SwiftUI

struct ChatView: View {
    static let tag: String? = "Chat"
    @ObservedObject var chatViewModel: ChatViewModel = ChatViewModel()
    @State private var monitorId: String = "w32tgse"

    var body: some View {
        NavigationSplitView {
            VStack {
                TextField("Monitor ID", text: $monitorId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    chatViewModel.connect(password: "password", monitor_id: monitorId)
                }) {
                    Text("Connect")
                }
                .padding()

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
        }
    }
}
