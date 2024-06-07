import Foundation

struct MilestoneResponse: Decodable {
    private(set) var success: Bool = false
    private(set) var milestones: [Milestone] = []

    init() {}
}
