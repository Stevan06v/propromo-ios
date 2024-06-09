import Foundation
import SwiftUI

struct LogInView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel

    init(viewModel: ViewModel) {
        _loginViewModel = ObservedObject(wrappedValue: LoginViewModel(viewModel: viewModel))
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                StepIndicator(currentStep: 1, dotCount: 1)
                    .padding(.leading, 35)
                    .padding(.top, 35)

                Spacer()
            }
            Form {
                Section(header: Text("Log In").font(.largeTitle).bold().padding(.bottom, 5)) {
                    TextField("E-Mail", text: Binding(get: {
                        loginViewModel.email
                    }, set: {
                        loginViewModel.dataChanged(email: $0)
                    }))
                    .textFieldStyle(TextFieldPrimaryStyle())
                    .autocapitalization(.none)

                    SecureField("Password", text: Binding(get: {
                        loginViewModel.password
                    }, set: {
                        loginViewModel.dataChanged(password: $0)
                    }))
                    .textFieldStyle(TextFieldPrimaryStyle())
                }
            }
            .formStyle(.columns)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Log In")
            .listSectionSpacing(0)
            .scrollContentBackground(.hidden)
            .padding(.horizontal, 35)
            .padding(.vertical, 15)

            HStack {
                Button(action: {
                    authenticationViewModel.showLogin = false
                }) {
                    Text("No Account?")
                }

                Spacer()

                Button(action: {
                    loginViewModel.login()
                }) {
                    Text("Log In")
                }
                .buttonStyle(.borderedProminent)
                .alert(isPresented: $loginViewModel.showAlert) {
                    Alert(
                        title: Text("Login Error"),
                        message: Text(loginViewModel.message)
                    )
                }
            }
            .padding(.horizontal, 35)

            Spacer()
        }
    }
}

#Preview {
    LogInView(viewModel: ViewModel())
}
