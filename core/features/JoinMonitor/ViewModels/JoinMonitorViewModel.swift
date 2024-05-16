import Foundation
import SwiftUI

class JoinMonitorViewModel: ObservableObject {
            
    @AppStorage("USER_KEY") var userKey: String = ""
    
    // alerts
    @Published public var showAlert: Bool = false
    @Published public var message: String = ""
    
    @Published private (set) var joinMonitorRequest: JoinMonitorRequest = JoinMonitorRequest()
    @Published private (set) var selectedView: String = "Home"
    
    var monitorHash: String {
        get  {
            joinMonitorRequest.monitorHash
        }
    }
    
    func dataChanged(monitorHash: String? = nil){
        joinMonitorRequest.dataChanged(monitorHash: monitorHash, email: self.userKey)
        print("\(self.joinMonitorRequest)")
    }
    

    func joinMonitor(){
        MonitorService().joinMonitor(joinMonitorRequest: joinMonitorRequest) { result in
            switch result {
            case .success(_):
                self.selectedView = "Monitors"
            case .failure(let error):
                print(error)
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }
    
        
}
