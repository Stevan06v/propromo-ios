import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    private var viewModel: ViewModel
    @AppStorage("AUTH_KEY") var authenticated: Bool = false
    @AppStorage("USER_PASSWORD") var userPassword: String = ""
    @AppStorage("USER_KEY") var userKey: String = ""
    
    // alerts
    @Published public var showAlert: Bool = false
    @Published public var message: String = ""
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
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
        LoginService().register(loginRequest: loginRequest) { result in
            switch result {
            case .success(let loginResponse):
                
                // set app-keys
                self.userKey = loginResponse.user.email
                self.userPassword = self.loginRequest.password
                self.authenticated = true
                
                print(loginResponse)
            
                
                self.viewModel.showAuthenticationView = false
            case .failure(let error):
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
       
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
   }
   
    
}
