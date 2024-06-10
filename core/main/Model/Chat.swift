import Foundation

struct Chat: Decodable, Identifiable, Hashable {
    private(set) var id: String = ""
    private(set) var team: String? = ""
    private(set) var type: String? = ""
    private(set) var title: String? = ""
    private(set) var description: String? = ""
    private(set) var isPublic: Bool?
    private(set) var createdAt: Date?
    private(set) var updatedAt: Date?
    private(set) var projectUrl: String? = ""
    private(set) var messages: [ChatMessage]? = []

    public mutating func setMessages(messages: [ChatMessage]) {
        self.messages = messages
    }

    init() {}

    init(id: String,
         team: String?,
         type: String?,
         title: String?,
         description: String?,
         isPublic: Bool?,
         createdAt: Date?,
         updatedAt: Date?,
         projectUrl: String?,
         messages: [ChatMessage]? = [])
    {
        self.id = id
        self.team = team
        self.type = type
        self.title = title
        self.description = description
        self.isPublic = isPublic
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.projectUrl = projectUrl
        self.messages = messages
    }

    init(id: String,
         monitor: ChatBody,
         messages: [ChatMessage]? = [])
    {
        self.id = id
        team = monitor.team
        type = monitor.type
        title = monitor.title
        description = monitor.description
        isPublic = monitor.isPublic
        createdAt = monitor.createdAt
        updatedAt = monitor.updatedAt
        projectUrl = monitor.projectUrl
        self.messages = messages
    }
}
