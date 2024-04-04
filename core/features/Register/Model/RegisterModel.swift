struct RegisterModel {
    
    private (set) var name: String = "";
    private (set) var email: String = "";
    private (set) var password: String = "";

    init(name: String, email: String, password: String){
        
        self.email = email
        self.name = name
        self.password = password
    }
}
