
import SwiftUI

class RegisterViewModel: ObservableObject {
    private var viewModel: ViewModel

    @AppStorage("AUTH_KEY") var authenticated: Bool = false
    @AppStorage("USER_KEY") var userKey: String = ""
    @AppStorage("USER_PASSWORD") var userPassword: String = ""

    @Published private(set) var registerRequest: RegisterRequest = .init()

    @Published public var showAlert: Bool = false
    @Published public var message: String = ""

    var email: String {
        registerRequest.email
    }

    var name: String {
        registerRequest.name
    }

    var password: String {
        registerRequest.password
    }

    var retypedPassword: String = ""
    var invalid: Bool = false

    func dataChanged(name: String? = nil, email: String? = nil, password: String? = nil) {
        registerRequest.dataChanged(name: name, email: email, password: password)
    }

    func register() {
        if registerRequest.password == retypedPassword {
            RegisterService().register(registerRequest: registerRequest) { result in
                switch result {
                case let .success(registerResponse):

                    // set app-keys
                    self.userKey = registerResponse.data.email
                    self.userPassword = self.registerRequest.password
                    self.authenticated = true

                    self.viewModel.showAuthenticationView = false

                case let .failure(error):
                    self.message = "\(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        } else {
            message = "Passwords do not match!"
            showAlert = true
        }
    }

    func login() {
        // router.navigate(to: .login)
    }

    func registerPressed() {
        print("Register Pressed")
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
