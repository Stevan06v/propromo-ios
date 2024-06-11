import Foundation

struct ChatLoginResponse: Decodable {
    let token: String
    let chats: [ChatInfo]
}
