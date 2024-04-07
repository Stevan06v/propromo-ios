
import Foundation
import SwiftUI


struct RegistrationView: View {
    
    @StateObject var registerViewModel: RegisterViewModel = RegisterViewModel()

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
                    TextField("Name", text: $registerViewModel.name)
                        .textFieldStyle(TextFieldPrimaryStyle()) .autocapitalization(.none)
                    
                    TextField("E-Mail", text: $registerViewModel.email)
                        .textFieldStyle(TextFieldPrimaryStyle()) .autocapitalization(.none)
                    
                    SecureField("Password", text: $registerViewModel.password)
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
                  print("fdfasd")
                }, label: {
                  Text("Already registered?")
                })
                Spacer()
                
                Button("Register", action: registerViewModel.register).buttonStyle(.borderedProminent)
                
            }.padding(.horizontal, 35)
            
            Spacer()
        }
    }

}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
