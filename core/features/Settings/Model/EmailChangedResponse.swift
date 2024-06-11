import Foundation

struct EmailChangedReponse: Decodable {
    private(set) var success: Bool = false
    private(set) var message: String = ""
    private(set) var error: String?

    init() {}
}
