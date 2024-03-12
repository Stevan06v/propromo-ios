//
//  RegisterView.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI

struct MonitorAuthenticationView: View {
    @State private var monitorToken = ""
    @State private var authenticationAppInstallId = "" // appInstallId is reserved :skull:
    @State private var authenticationView = 0 // -1
    @Binding var selectedView: Int

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                StepIndicator(currentStep: 2, dotCount: 3)
                    .padding(.leading, 35)
                    .padding(.top, 35)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Authentication")
            
            switch authenticationView {
                case 0: // APP
                HStack {
                    Button(action: useAppAuthentication) {
                        Text("Install App")
                    }
                    .padding(.horizontal, 35)
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 150)
                    .padding(.horizontal, 35)
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: Text("ConfirmationView")) {
                        Text("Authenticate")
                    }.buttonStyle(.borderedProminent)
                }.padding(.horizontal, 35)
                
                Spacer()
                
                VStack {
                    HStack {
                        Button(action: useTokenAuthentication) {
                            Text("Use Token instead")
                        }.padding(.horizontal, 35)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: useInstalledAppAuthentication) {
                            Text("App already installed?")
                        }.padding(.horizontal, 35)
                        
                        Spacer()
                    }
                }
                case 1: // APP already installed
                Form {
                    Section {
                        TextField("Install-ID", text: $authenticationAppInstallId)
                            .textFieldStyle(TextFieldPrimaryStyle())
                    }
                }
                .formStyle(.columns)
                .listSectionSpacing(0)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 35)
                .padding(.vertical, 15)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 150)
                    .padding(.horizontal, 35)
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: Text("ConfirmationView")) {
                        Text("Authenticate")
                    }.buttonStyle(.borderedProminent)
                }.padding(.horizontal, 35)
                
                Spacer()
                
                VStack {
                    HStack {
                        Button(action: useTokenAuthentication) {
                            Text("Use Token instead")
                        }.padding(.horizontal, 35)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button(action: useAppAuthentication) {
                            Text("No App registered yet?")
                        }.padding(.horizontal, 35)
                        
                        Spacer()
                    }
                }
                default: // TOKEN
                Form {
                    Section {
                        TextField("Authentication Token", text: $monitorToken)
                            .textFieldStyle(TextFieldPrimaryStyle())
                    }
                }
                .formStyle(.columns)
                .listSectionSpacing(0)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 35)
                .padding(.vertical, 15)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 150)
                    .padding(.horizontal, 35)
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: Text("ConfirmationView")) {
                        Text("Authenticate")
                    }.buttonStyle(.borderedProminent)
                }.padding(.horizontal, 35)
                
                Spacer()
                
                HStack {
                    Button(action: useAppAuthentication) {
                        Text("Use App Authentication instead")
                    }.padding(.horizontal, 35)
                    
                    Spacer()
                }
            }
        }
    }
    
    private func useTokenAuthentication() {
        authenticationView = -1
    }
    
    private func useAppAuthentication() {
        authenticationView = 0
    }
    
    private func useInstalledAppAuthentication() {
        authenticationView = 1
    }
    
    private func installApp() {
        // install app
    }
}

struct MonitorAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        MonitorAuthenticationView(selectedView: .constant(1))
    }
}
