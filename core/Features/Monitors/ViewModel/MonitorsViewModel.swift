//
//  MonitorsViewModel.swift
//  Propromo
//
//  Created by Stevan Vlajic on 24.04.24.
//

import Foundation
import SwiftUI

class MonitorsViewModel: ObservableObject {
    @AppStorage("USER_KEY") var userKey: String = ""
    
    // alerts
    @Published public var showAlert: Bool = false
    @Published public var message: String = ""
    @Published public var monitorsModel: MonitorsModel = MonitorsModel()
    
    public func getMonitors() {
        MonitorService().getMonitorsByEmail(email: self.userKey) { result in
            switch result {
            case .success(let monitorsResponse):
                self.monitorsModel.setMonitors(monitors: monitorsResponse.monitors)
            case .failure(let error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }
    
    public func getRepositories(monitor: Monitor) {
        RepositoryService().getRepositoriesBy(monitor: monitor) { result in
            switch result {
            case .success(let repositoryResponse):
                self.monitorsModel.setMonitorRepositories(monitor: monitor, repositories:  repositoryResponse.data.organization.projectV2.repositories.nodes)
            case .failure(let error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }
}
