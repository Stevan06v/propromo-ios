//
//  RegisterView.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct MonitorConfirmationView: View {
    @State private var monitorName = ""
    @State private var monitorId = ""
    @State private var monitorAuthentication = ""
    @State private var monitorProvider = 1
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
                    Picker("Select a provider", selection: $monitorProvider) {
                        Text("Github").tag(1)
                        Text("Jira").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Project (Monitor) URL", text: $monitorUrl)
                        .textFieldStyle(TextFieldPrimaryStyle())
                    
                    TextField("Authentication", text: $monitorAuthentication)
                        .textFieldStyle(TextFieldPrimaryStyle())
                }
            }
            .formStyle(.columns)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Confirmation")
            .listSectionSpacing(0)
            .scrollContentBackground(.hidden)
            .padding(.horizontal, 35)
            .padding(.vertical, 15)
            
            HStack {
                Spacer()
                
                NavigationLink(destination: Text("Home")) {
                    Text("Confirm")
                }.buttonStyle(.borderedProminent)
            }.padding(.horizontal, 35)
            
            Spacer()
            
            VStack {
                Form {
                    Section {
                        TextField("Name", text: $monitorName)
                            .textFieldStyle(TextFieldPrimaryStyle())
                        
                        CopiableMonitorIdTextField(text: $monitorId)
                    }
                }
                .formStyle(.columns)
                .listSectionSpacing(0)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 35)
                .padding(.vertical, 15)
            }
        }
    }
}

struct CopiableMonitorIdTextField: View {
    @Binding var text: String
    @State private var showCopyAlert = false

    var body: some View {
        HStack {
            TextField("Monitor-ID", text: $text)
                .textFieldStyle(TextFieldPrimaryStyle())

            Button(action: {
                self.copyToClipboard()
                self.showCopyAlert = true
            }) {
                Image(systemName: "doc.on.clipboard")
                    .imageScale(.large)
                    .frame(height: 40) // .infinity
            }
            .buttonStyle(.bordered)
            .alert(isPresented: $showCopyAlert) {
                Alert(title: Text("Copied!"), message: Text("The monitor ID has been copied to the clipboard."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.setValue(text,
                    forPasteboardType: UTType.utf8PlainText.identifier)
    }
}

struct MonitorConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        MonitorConfirmationView()
    }
}
