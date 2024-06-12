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
        var processedMonitorHash = monitorHash

        if let monitorHash = monitorHash,
           let range = monitorHash.range(of: "/join/") {
            processedMonitorHash = String(monitorHash[range.upperBound...])
        }

        joinMonitorRequest.dataChanged(monitorHash: processedMonitorHash, email: userKey)
        print("\(joinMonitorRequest)")
    }

    func joinMonitor() {
        MonitorService().joinMonitor(joinMonitorRequest: joinMonitorRequest) { result in
            switch result {
            case .success:
                self.message = "Successfully joined the monitor!"
                self.showAlert = true
            case let .failure(error):
                print(error)
                self.message = "Monitor with that ID does not exsist or you already joined!"
                self.showAlert = true
            }
        }
    }
}
