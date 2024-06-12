import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    private var viewModel: ViewModel
    @AppStorage("USER_KEY") var userKey: String = ""
    @AppStorage("USER_PASSWORD") var userPassword: String = ""
    @AppStorage("AUTH_KEY") var authenticated: Bool = false

    @Published private(set) var emailChangedRequest: EmailChangedRequest = .init()
    @Published private(set) var passwordChangedRequest: PasswordChangedRequest = .init()
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var oldPassword: String {
        passwordChangedRequest.oldPassword
    }

    var newEmail: String {
        emailChangedRequest.newEmail
    }

    var newPassword: String {
        passwordChangedRequest.newPassword
    }

    var confirmNewPassword: String {
        passwordChangedRequest.confirmNewPassword
    }

    func dataChanged(newEmail: String? = nil, confirmNewPassword: String? = nil, newPassword: String? = nil, oldPassword: String? = nil) {
        emailChangedRequest.dataChanged(newEmail: newEmail, email: userKey)
        passwordChangedRequest.dataChanged(oldPassword: oldPassword, confirmNewPassword: confirmNewPassword, newPassword: newPassword, email: userKey)
    }

    func updateEmail() {
        SettingsService().updateEmail(emailChangedRequest: emailChangedRequest) { result in
            switch result {
            case let .success(emailChangedResponse):
                print(emailChangedResponse)
                self.showAlert = true
                self.alertMessage = "Email successfully updated!"
            case let .failure(error):
                self.showAlert = true
                self.alertMessage = "\(error.localizedDescription)"

                print("\(error.localizedDescription)")
            }
        }
    }

    func logout() {
        print("Logout pressed")
        authenticated = false
        viewModel.showAuthenticationView = true
    }

    func updatePassword() {
        if oldPassword == userPassword {
            if newPassword == confirmNewPassword {
                SettingsService().updatePassword(passwordChangedRequest: passwordChangedRequest) { result in
                    switch result {
                    case let .success(passwordChangedResponse):
                        print(passwordChangedResponse)
                        self.showAlert = true
                        self.alertMessage = "Password successfully updated!"
                    case let .failure(error):
                        self.showAlert = true
                        self.alertMessage = "Your password must be >= 6 characters."
                        print("\(error.localizedDescription)")
                    }
                }
            } else {
                showAlert = true
                alertMessage = "Passwords do not match!"
            }
        } else {
            alertMessage = "Wrong password used!"
            showAlert = true
        }
    }
}
