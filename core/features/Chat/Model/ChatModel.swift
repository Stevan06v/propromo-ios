import Foundation

struct ChatModel {
    private(set) var chats: [Chat] = []

    mutating func setChats(chats: [Chat]) {
        print("setting chats")
        self.chats = chats
    }

    func getChats() -> [Chat] {
        print("getting chats")
        return chats.map { $0 }
    }

    init() {}
}
