import Foundation


class LoginViewModel: ObservableObject {
    
    private var router: Router
    
    @Published private (set) var loginRequest: LoginRequest = LoginRequest()
    
    var email: String {
        get  {
            loginRequest.email
        }
    }
    
    var password: String {
        get {
            loginRequest.password
        }
    }
    
    func dataChanged(email: String? = nil, password: String? = nil){
        loginRequest.dataChanged(email: email, password: password)
    }
    
    func login(){
        print(loginRequest)
        
    }
    
    init(router: Router) {
        self.router = router
    }
    
}
