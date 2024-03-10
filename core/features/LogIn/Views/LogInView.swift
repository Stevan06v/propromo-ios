//
//  RegisterView.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI

struct LogInView: View {
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
                NavigationLink(destination: RegisterView()) {
                    Text("No Account?")
                }
                
                Spacer()
                
                Button(action: logInButtonTapped) {
                    Text("Log In")
                }
                .buttonStyle(.borderedProminent)
            }.padding(.horizontal, 35)
            
            Spacer()
        }
    }

    private func logInButtonTapped() {
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
