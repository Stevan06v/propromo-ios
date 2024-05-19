import Foundation

struct ChatModel {
    private (set) var chats: [Chat] = []

    mutating func setChats(chats: [Chat]){
        self.chats = chats
    }

    func getChats() -> [Chat] {
        return self.chats.map { $0 }
    }

    init(){}
}
