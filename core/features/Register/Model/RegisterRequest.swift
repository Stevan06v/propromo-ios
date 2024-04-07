struct RegisterRequest: Encodable {
    
    private (set) var name: String = ""
    private (set) var email: String = ""
    private (set) var password: String = ""
    private var authType = "PROPORMO"
    
    
    mutating func dataChanged(name: String? = nil, email: String? = nil, password: String? = nil){
        if let val = name {
            self.name = val
        }
        if let val = email {
            self.email = val
        }
        if let val = password {
            self.password = val
        }
    }
}
