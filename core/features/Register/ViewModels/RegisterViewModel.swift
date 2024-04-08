
import SwiftUI
class RegisterViewModel: ObservableObject{
    
    // app-storage values
    @AppStorage("AUTH_KEY") var authenticated: Bool = false
    @AppStorage("USER_KEY") var userKey: String = ""
    
    @Published private (set) var registerRequest: RegisterRequest = RegisterRequest()
    
    private var router: Router
    
    // alerts
    @Published public var showAlert: Bool = false
    @Published public var message: String = ""
    
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
                    self.message = "\(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        }else{
            self.message = "Passwords do not match!"
            self.showAlert = true
        }
    }
    
    func login(){
        router.navigate(to: .login)
    }
    
    func registerPressed() {
        print("Register Pressed")
    }
}
