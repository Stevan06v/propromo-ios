import Foundation

struct ChatBody: Decodable {
    let team: String
    let type: String
    let title: String
    let description: String
    let isPublic: Bool
    let createdAt: Date
    let updatedAt: Date
    let projectUrl: String
}
