import Foundation

struct RepositoryModel {
    private(set) var repositories: [Repository] = []

    mutating func setRepositories(repositories: [Repository]) {
        self.repositories = repositories
    }

    init() {}
}
