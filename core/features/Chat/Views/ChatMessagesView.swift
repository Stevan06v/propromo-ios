import Foundation
import SwiftUI

struct ChatMessagesView: View {
    @ObservedObject var chatViewModel: ChatViewModel
    var selectedChat: Chat

    @AppStorage("USER_KEY") var email: String = ""
    @State private var messageText: String = ""

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView {
                    ScrollViewReader { value in
                        let messages = chatViewModel.chatsModel.chats.first(where: { $0.id == selectedChat.id })?.messages ?? []

                        MessageList(
                            messages: messages,
                            email: email,
                            geometry: geometry
                        ).onChange(of: messages.count) {
                            if let lastMessageId = messages.last?.id {
                                value.scrollTo(lastMessageId, anchor: .bottom)
                            }
                        }
                    }
                }
                .padding()
            }

            MessageInputView(messageText: $messageText, sendMessage: {
                chatViewModel.sendMessage($0, to: selectedChat.id)
            })
            .border(width: 1, edges: [.top], color: .gray)
        }
        .navigationTitle(selectedChat.title ?? "Scrum Master")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct MessageList: View {
    let messages: [ChatMessage]
    let email: String
    let geometry: GeometryProxy

    var body: some View { // messages, id: \.self
        ForEach(Array(messages.sorted { $0.timestamp ?? "" < $1.timestamp ?? "" }), id: \.self) { message in
            MessageView(message: message, email: email, geometry: geometry)
        }
    }
}

struct MessageView: View {
    let message: ChatMessage
    let email: String
    let geometry: GeometryProxy

    var body: some View {
        VStack(alignment: .leading) {
            let formattedDate = formatTimestamp(message.timestamp ?? "")

            if message.email == email {
                OutgoingMessageView(message: message, formattedDate: formattedDate, geometry: geometry)
            } else {
                IncomingMessageView(message: message, formattedDate: formattedDate, geometry: geometry)
            }
        }
    }
}

struct OutgoingMessageView: View {
    let message: ChatMessage
    let formattedDate: String
    let geometry: GeometryProxy

    var body: some View {
        HStack(alignment: .top) {
            Spacer()
            VStack(alignment: .trailing) {
                Text(message.text ?? "")
                HStack {
                    Text(formattedDate)
                        .font(.caption)
                        .foregroundStyle(Color(UIColor.systemGray3))
                        .padding(.top, 5)
                }
            }.frame(width: (geometry.size.width * 0.5) - 2, alignment: .trailing)
                .padding()
                .cornerRadius(5)
                .background(Color(UIColor.systemGray6))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(UIColor.systemGray3), lineWidth: 1)
                )
        }.frame(alignment: .trailing)
    }
}

struct IncomingMessageView: View {
    let message: ChatMessage
    let formattedDate: String
    let geometry: GeometryProxy

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(message.text ?? "")
                HStack {
                    Spacer()
                    Text(formattedDate)
                        .font(.caption)
                        .foregroundStyle(Color(UIColor.systemGray3))
                        .padding(.top, 5)
                }
            }.frame(width: (geometry.size.width * 0.5) - 2, alignment: .leading)
                .padding()
                .cornerRadius(5)
                .background(Color(UIColor.systemGray6))
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(UIColor.systemGray3), lineWidth: 1)
                )
            Spacer()
        }.frame(width: .infinity, alignment: .trailing)
    }
}

struct MessageInputView: View {
    @Binding var messageText: String
    let sendMessage: (String) -> Void

    var body: some View {
        HStack {
            TextField("Type your message", text: $messageText)
                .textFieldStyle(.roundedBorder)
            Button(action: {
                if !messageText.isEmpty {
                    sendMessage(messageText)
                    messageText = ""
                }
            }) {
                Text("Send")
            }
            .buttonStyle(.borderedProminent)
            .disabled(messageText.isEmpty)
        }
        .padding()
    }
}
