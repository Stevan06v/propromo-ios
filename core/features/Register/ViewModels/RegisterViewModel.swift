
import SwiftUI
class RegisterViewModel: ObservableObject{
    
    // app-storage values
    @AppStorage("AUTH_KEY") var authenticated: Bool = false
    @AppStorage("USER_KEY") var userKey: String = ""
    
    
    @Published private (set) var registerRequest: RegisterRequest = RegisterRequest()
    private var router: Router
    
    var email: String {
        get  {
            registerRequest.email
        }
    }
    
    var name: String {
        get {
            registerRequest.name
        }
    }
    var password: String {
        get {
            registerRequest.password
        }
    }
    var retypedPassword: String = ""
    var invalid: Bool = false
    
    
    func dataChanged(name: String? = nil, email: String? = nil, password: String? = nil){
        registerRequest.dataChanged(name: name, email: email, password: password)
        
        print(registerRequest)
    }
    
    init(router: Router) {
        self.router = router
    }
    
    func register() {
        if (registerRequest.password == retypedPassword){
            RegisterService().register(registerRequest: registerRequest) { result in
                switch result {
                case .success(let registerResponse):
                    
                    // set app-keys
                    self.userKey = registerResponse.data.email
                    self.authenticated = true
                    
                    // jump to home if authenticated
                    self.router.navigate(to: .home)
                    
                case .failure(let error):
                    print("Registration failed: \(error.localizedDescription)")
                }
            }
        }else{
            print("passwor incorrect")
        }
    }
    
    func login(){
        router.navigate(to: .login)
    }
    
    func registerPressed() {
        print("Register Pressed")
    }
}
