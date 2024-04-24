

struct JoinMonitorRequest: Encodable {
    
    private (set) var email: String = ""
    private (set) var monitorHash: String = ""

    
    mutating func dataChanged(monitorHash: String? = nil, email: String? = nil){
        if let val = monitorHash {
            self.monitorHash = val
        }
        if let val = email {
            self.email = val
        }
    }
}
    
