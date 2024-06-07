import Foundation

class ChatMessageViewModel: ObservableObject {
    let id: String
    @Published var message: ChatMessage

    init(message: ChatMessage) {
        id = message.id ?? UUID().uuidString
        self.message = message
    }

    static func == (lhs: ChatMessageViewModel, rhs: ChatMessageViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
