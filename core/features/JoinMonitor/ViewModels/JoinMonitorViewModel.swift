import Foundation
import SwiftUI

class JoinMonitorViewModel: ObservableObject {
    @AppStorage("USER_KEY") var userKey: String = ""

    // alerts
    @Published public var showAlert: Bool = false
    @Published public var message: String = ""

    @Published private(set) var joinMonitorRequest: JoinMonitorRequest = .init()
    @Published private(set) var selectedView: String = "Home"

    var monitorHash: String {
        joinMonitorRequest.monitorHash
    }

    func dataChanged(monitorHash: String? = nil) {
        joinMonitorRequest.dataChanged(monitorHash: monitorHash, email: userKey)
        print("\(joinMonitorRequest)")
    }

    func joinMonitor() {
        MonitorService().joinMonitor(joinMonitorRequest: joinMonitorRequest) { result in
            switch result {
            case .success:
                self.selectedView = "Monitors"
            case let .failure(error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }
}
