import SwiftUI
import Foundation

struct ChatMessageView: View {
    @ObservedObject var chatViewModel: ChatViewModel
    // @StateObject private var messageViewModel = ChatMessageViewModel(message: ChatMessage())
    
    @State private var messageText: String = ""

    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatViewModel.chatsModel.chats.first?.messages ?? [], id: \.self) { message in // ([messageViewModel.message])
                    VStack(alignment: .leading) {
                        Text(message.email ?? "")
                        Text(message.timestamp ?? "")
                        Text(message.text ?? "")
                    }
                }
            }

            HStack {
                TextField("Type your message", text: $messageText)
                Button(action: {
                    chatViewModel.sendMessage(messageText)
                    messageText = ""
                }) {
                    Text("Send")
                }
            }
        }
        .padding()
    }
}
