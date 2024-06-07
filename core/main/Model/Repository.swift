import Foundation

struct Repository: Decodable, Identifiable, Hashable {
    private(set) var id: Int = 0
    private(set) var name: String? = ""
    private(set) var description: String? = ""

    init() {}
}
