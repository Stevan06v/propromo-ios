//
//  RegisterView.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI

struct JoinMonitorView: View {
    @State private var monitorId = ""
    
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
                    TextField("Monitor-ID", text: $monitorId)
                        .textFieldStyle(TextFieldPrimaryStyle())
                }
            }
            .formStyle(.columns)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Join Monitor")
            .listSectionSpacing(0)
            .scrollContentBackground(.hidden)
            .padding(.horizontal, 35)
            .padding(.vertical, 15)
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 150)
                .padding(.horizontal, 35)
            
            HStack {
                Button {
                    print("button clicked...")
                } label: {
                    Text("skip")
                }

                Spacer()
                
                NavigationLink(destination: MonitorConfirmationView()) {
                    Text("Join")
                }.buttonStyle(.borderedProminent)
            }.padding(.horizontal, 35)
            
            Spacer()
            
            HStack {
                NavigationLink(destination: ChooseProviderView()) {
                    Text("Create one instead")
                }.padding(.horizontal, 35)
                
                Spacer()
            }
        }
    }
    
}

struct JoinMonitor_Previews: PreviewProvider {
    static var previews: some View {
        JoinMonitorView()
    }
}
