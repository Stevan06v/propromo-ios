import Foundation
import SwiftUI

func formatTimestamp(_ timestamp: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: timestamp)
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    dateFormatter.locale = .current
    return dateFormatter.string(from: date!)
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct ChatMessageView: View {
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
                .frame(width: .infinity)
                .navigationTitle(selectedChat.title ?? "Scrum Master")
            }

            MessageInputView(messageText: $messageText, sendMessage: {
                chatViewModel.sendMessage($0, to: selectedChat.id)
            })
            .border(width: 1, edges: [.top], color: .gray)
        }
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
        }.frame(width: .infinity, alignment: .trailing)
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
                sendMessage(messageText)
                messageText = ""
            }) {
                Text("Send")
            }.buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
