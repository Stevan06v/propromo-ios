import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    private var viewModel: ViewModel
    @AppStorage("AUTH_KEY") var authenticated: Bool = false
    @AppStorage("USER_KEY") var userKey: String = ""

    // alerts
    @Published public var showAlert: Bool = false
    @Published public var message: String = ""

    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel

    @Published private(set) var loginRequest: LoginRequest = .init()

    var email: String {
        loginRequest.email
    }

    var password: String {
        loginRequest.password
    }

    func dataChanged(email: String? = nil, password: String? = nil) {
        loginRequest.dataChanged(email: email, password: password)
    }

    func login() {
        LoginService().register(loginRequest: loginRequest) { result in
            switch result {
            case let .success(loginResponse):

                // set app-keys
                self.userKey = loginResponse.user.email
                self.authenticated = true

                print(loginResponse)

                // jump to home if authenticated
                // self.router.navigate(to: .home)

                self.viewModel.showAuthenticationView = false
            case let .failure(error):
                self.message = "\(error.localizedDescription)"
                self.showAlert = true
            }
        }
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
