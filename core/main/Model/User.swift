import Foundation

struct User: Decodable {
    private(set) var name: String = ""
    private(set) var email: String = ""
    private(set) var auth_type: String = ""
    private(set) var updated_at: String = ""
    private(set) var created_at: String = ""

    init() {}
}
