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
    @Binding var selectedView: Int

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
                Button(action: logInDashboardButtonTapped) {
                    Text("Skip")
                }
                
                Spacer()
                
                NavigationLink(destination: MonitorConfirmationView(selectedView: $selectedView)) {
                    Text("Join")
                }.buttonStyle(.borderedProminent)
            }.padding(.horizontal, 35)
            
            Spacer()
            
            HStack {
                NavigationLink(destination: ChooseProviderView(selectedView: $selectedView)) {
                    Text("Create one instead")
                }.padding(.horizontal, 35)
                
                Spacer()
            }
        }
    }
    
    private func logInDashboardButtonTapped() { // register action => login action => home
        selectedView = 1
    }
}

struct JoinMonitor_Previews: PreviewProvider {
    static var previews: some View {
        JoinMonitorView(selectedView: .constant(1))
    }
}
