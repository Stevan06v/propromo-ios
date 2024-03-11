//
//  RegisterView.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var retypePassword = ""
    @Binding var selectedView: Int

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
                    TextField("E-Mail", text: $email)
                        .textFieldStyle(TextFieldPrimaryStyle())
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(TextFieldPrimaryStyle())
                    
                    SecureField("Retype Password", text: $retypePassword)
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
                Button(action: logInButtonTapped) {
                    Text("Already Registered?")
                }
                
                Spacer()
                
                NavigationLink(destination: ChooseProviderView(selectedView: $selectedView)) {
                    Text("Register")
                }.buttonStyle(.borderedProminent)
            }.padding(.horizontal, 35)
            
            Spacer()
        }
    }

    private func logInButtonTapped() {
        selectedView = 0
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(selectedView: .constant(1))
    }
}
