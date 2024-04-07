//
//  RegisterView.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI

struct CreateMonitorView: View {
    @State private var monitorName = ""
    @State private var monitorUrl = ""

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                StepIndicator(currentStep: 2, dotCount: 3)
                    .padding(.leading, 35)
                    .padding(.top, 35)
                
                Spacer()
            }
            
            Form {
                Section {
                    TextField("Monitor Name", text: $monitorName)
                        .textFieldStyle(TextFieldPrimaryStyle())
                    
                    TextField("Project (Monitor) URL", text: $monitorUrl)
                        .textFieldStyle(TextFieldPrimaryStyle())
                }
            }
            .formStyle(.columns)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Create Monitor")
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
                
                NavigationLink(destination: MonitorAuthenticationView()) {
                    Text("Create")
                }.buttonStyle(.borderedProminent)
            }.padding(.horizontal, 35)
            
            Spacer()
            
            HStack {
                NavigationLink(destination: JoinMonitorView()) {
                    Text("Join one instead")
                }.padding(.horizontal, 35)
                
                Spacer()
            }
        }
    }
}

struct CreateMonitor_Previews: PreviewProvider {
    static var previews: some View {
        CreateMonitorView()
    }
}
