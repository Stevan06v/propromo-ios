import Foundation

struct RepositoryResponse: Decodable {
    private(set) var success: Bool = false
    private(set) var repositories: [Repository] = []

    init() {}
}
