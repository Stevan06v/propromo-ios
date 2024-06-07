import Foundation

struct LoginReponse: Decodable {
    private(set) var success: Bool = false
    private(set) var message: String = ""
    private(set) var user: User = .init()

    init() {}
}
