import Foundation
import SwiftUI

struct ChatMessageView: View {
    @ObservedObject var chatViewModel: ChatViewModel
    var selectedChat: Chat
    // @StateObject private var messageViewModel = ChatMessageViewModel(message: ChatMessage())

    @State private var messageText: String = ""

    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatViewModel.chatsModel.chats.first(where: { $0.monitor_hash == selectedChat.monitor_hash })?.messages ?? [], id: \.self) { message in // ([messageViewModel.message])
                    VStack(alignment: .leading) {
                        Text(message.email ?? "")
                        Text(message.timestamp ?? "")
                        Text(message.text ?? "")
                    }.frame(maxWidth:.infinity)
                }
            }

            HStack {
                TextField("Type your message", text: $messageText)
                Button(action: {
                    chatViewModel.sendMessage(messageText, to: selectedChat.monitor_hash)
                    messageText = ""
                }) {
                    Text("Send")
                }
            }
        }
        .padding()
    }
}
