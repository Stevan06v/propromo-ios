import Foundation
import SwiftUI

class MonitorsViewModel: ObservableObject {
    @AppStorage("USER_KEY") var userKey: String = ""

    // alerts
    @Published public var showAlert: Bool = false
    @Published public var message: String = ""
    @Published public var monitorsModel: MonitorsModel = .init()
    @Published public var repositoryModel: RepositoryModel = .init()
    @Published public var milestoneModel: MilestoneModel = .init()

    public func getMonitors() {
        MonitorService().getMonitorsByEmail(email: userKey) { result in
            switch result {
            case let .success(monitorsResponse):
                self.monitorsModel.setMonitors(monitors: monitorsResponse.monitors)
            case let .failure(error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }

    public func getRepositoriesByMonitorId(monitorId: Int) {
        RepositoryService().getRepositoriesByMonitorId(monitorId: monitorId) { result in
            switch result {
            case let .success(repositoryResponse):
                self.repositoryModel.setRepositories(repositories: repositoryResponse.repositories)
            case let .failure(error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }

    public func getMilestonesByRepositoryId(repositoryId: Int) {
        MilestoneService().getMilestonesByRepositoryId(repositoryId: repositoryId) { result in
            switch result {
            case let .success(milestoneResponse):
                self.milestoneModel.setMilestones(milestones: milestoneResponse.milestones)
            case let .failure(error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }
}
