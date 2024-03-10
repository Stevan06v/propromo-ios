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

    var body: some View {
        VStack(alignment: .center) {
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
                NavigationLink(destination: LogInView()) {
                    Text("Already Registered?")
                }
                
                Spacer()
                
                Button(action: registerButtonTapped) {
                    Text("Register")
                }
                .buttonStyle(.borderedProminent)
            }.padding(.horizontal, 35)
            
            Spacer()
        }
    }

    private func registerButtonTapped() {
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
