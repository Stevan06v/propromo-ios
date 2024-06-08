import SwiftUI

struct ChatView: View {
    static let tag: String? = "Chat"
    @ObservedObject var chatViewModel: ChatViewModel = .init()
    @State private var monitorId: String = "$2y$12$W3pHWdAtePn1wjCm4.t4xO9lY9jOcu8/5SC0bDEsaAfSB8pKA5k.K"

    var body: some View {
        NavigationSplitView {
            VStack {
                TextField("Monitor ID", text: $monitorId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    chatViewModel.connect(monitor_id: monitorId)
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
