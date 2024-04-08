//
//  RegisterView.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var router: Router
    @ObservedObject var loginViewModel: LoginViewModel
    
    init(router: Router){
        _loginViewModel = ObservedObject(wrappedValue: LoginViewModel(router: router))
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
                    TextField("E-Mail", text: Binding(get: {
                        loginViewModel.email
                    }, set: {
                        loginViewModel.dataChanged(email: $0)
                    }))
                    .textFieldStyle(TextFieldPrimaryStyle()) .autocapitalization(.none)

                    SecureField("Password",  text: Binding(get: {
                        loginViewModel.password
                    }, set: {
                        loginViewModel.dataChanged(password: $0)
                    }))
                    .textFieldStyle(TextFieldPrimaryStyle())
                }
                
                HStack {
                    Spacer()
                    
                    Text("or")
                    
                    Spacer()
                }.padding()
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    HStack {
                        WebView(svgString: SVGIcons.google(size: 125))
                            .padding(.top, 4)
                        WebView(svgString: SVGIcons.github(size: 150))
                    }.frame(width: 100.0, height: 50.0)
                    
                    Spacer()
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
                    loginViewModel.register()
                }) {
                    Text("No Account?")
                }
                
                Spacer()
                
                Button(action: {
                    loginViewModel.login()
                }) {
                    Text("Log In")
                }.buttonStyle(.borderedProminent)
                    .alert(isPresented: $loginViewModel.showAlert)
                {
                    Alert(
                        title: Text("Login Error"),
                        message: Text(loginViewModel.message)
                    )
                }
                
            }.padding(.horizontal, 35)
            
            Spacer()
        }
    }
}
