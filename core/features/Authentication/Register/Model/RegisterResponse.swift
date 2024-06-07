import Foundation

struct RegisterResponse: Decodable {
    private(set) var success: Bool = false
    private(set) var message: String = ""
    private(set) var data: User = .init()

    init() {}
}
