import Foundation

struct MilestoneModel {
    private(set) var milestones: [Milestone] = []

    mutating func setMilestones(milestones: [Milestone]) {
        self.milestones = milestones
    }

    init() {}
}
