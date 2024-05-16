
import Foundation
import SwiftUI


struct RegistrationView: View {
    @ObservedObject var registerViewModel: RegisterViewModel
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel;

    
    init(viewModel: ViewModel){
        _registerViewModel = ObservedObject(wrappedValue: RegisterViewModel(viewModel: viewModel))
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            HStack {
                StepIndicator(currentStep: 1, dotCount: 3)
                    .padding(.leading, 35)
                    .padding(.top, 35)
                
                Spacer()
            }
            
            Form {
                Section {
                    TextField("Name", text: Binding(get: {
                        registerViewModel.name
                    }, set: {
                        registerViewModel.dataChanged(name: $0)
                    })).textFieldStyle(TextFieldPrimaryStyle()) .autocapitalization(.none)
                    
                    TextField("E-Mail", text: Binding(get: {
                        registerViewModel.email
                    }, set: {
                        registerViewModel.dataChanged(email: $0)
                    }))
                    .textFieldStyle(TextFieldPrimaryStyle()) .autocapitalization(.none)
                    
                    SecureField("Password", text: Binding(get: {
                        registerViewModel.password
                    }, set: {
                        registerViewModel.dataChanged(password: $0)
                    }))
                    .textFieldStyle(TextFieldPrimaryStyle())
                    
                    SecureField("Retype Password", text: $registerViewModel.retypedPassword)
                        .textFieldStyle(TextFieldPrimaryStyle())
                }
            }
            .formStyle(.columns)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Register")
            .listSectionSpacing(0)
            .scrollContentBackground(.hidden)
            .padding(.horizontal, 35)
            .padding(.vertical, 15)
            
            HStack {
                Button(action: {
                    authenticationViewModel.showLogin = true
                }, label: {
                    Text("Already registered?")
                })
                Spacer()
                
                Button(action: {
                    registerViewModel.register()
                }, label: {
                    Text("Register")
                }).buttonStyle(.borderedProminent)
                    .alert(isPresented: $registerViewModel.showAlert)
                {
                    Alert(
                        title: Text("Registration Error"),
                        message: Text(registerViewModel.message)
                    )
                }
                
                
            }.padding(.horizontal, 35)
            
            Spacer()
        }
    }
    
}
