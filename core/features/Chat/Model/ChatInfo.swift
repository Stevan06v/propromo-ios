import Foundation

struct ChatInfo: Decodable {
    private(set) var monitor_hash: String
    private(set) var organization_name: String?
    private(set) var type: String?
    private(set) var title: String?
    private(set) var short_description: String?
    private(set) var `public`: Bool?
    private(set) var created_at: String?
    private(set) var updated_at: String?
    private(set) var project_url: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        monitor_hash = try container.decode(String.self, forKey: .monitor_hash)
        organization_name = try container.decodeIfPresent(String.self, forKey: .organization_name)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        short_description = try container.decodeIfPresent(String.self, forKey: .short_description)
        `public` = try container.decodeIfPresent(Bool.self, forKey: .public)
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        project_url = try container.decodeIfPresent(String.self, forKey: .project_url)
    }

    enum CodingKeys: String, CodingKey {
        case monitor_hash
        case organization_name
        case type
        case title
        case short_description
        case `public`
        case created_at
        case updated_at
        case project_url
    }
}
