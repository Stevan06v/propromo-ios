//
//  TextFieldStyle.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var joinMonitorViewModel: JoinMonitorViewModel
    static let tag: String? = "Home"

    @SceneStorage("selectedView") var selectedView: String?

    init(router: Router){
        _joinMonitorViewModel = ObservedObject(wrappedValue: JoinMonitorViewModel(router: router))
    }

    var body: some View {
        VStack(alignment: .center) {
            WebView(svgString: SVGIcons.logo())
                .frame(height: 380)
            
            Text("Propromo")
                .bold()
                .font(.largeTitle)
                .textCase(.uppercase)
            
            Text("Project Progress Monitoring")
                .bold()
                .font(.subheadline)
                .foregroundStyle(Color.gray)
                .textCase(.uppercase)
                .padding(.bottom, 20)

            Text("Works with Github")
                .bold()
                .font(.caption)
                .foregroundStyle(Color.gray)
                .textCase(.uppercase)
                .padding(.bottom, 40)
            
            HStack {
                TextField("Monitor-ID", text: Binding(get: {
                    joinMonitorViewModel.monitorHash
                }, set: {
                    joinMonitorViewModel.dataChanged(monitorHash: $0)
                }))
                    .textFieldStyle(TextFieldPrimaryStyle())
                
                Button(action: {
                    joinMonitorViewModel.joinMonitor()
                    self.selectedView = MonitorsView.tag
                }, label: {
                    Text("Join")
                }).buttonStyle(.borderedProminent)
                    .alert(isPresented: $joinMonitorViewModel.showAlert)
                {
                    Alert(
                        title: Text("Login Error"),
                        message: Text(joinMonitorViewModel.message)
                    )
                }

            }
            .padding(.horizontal, 35)
            .padding(.vertical, 15)
            
            Spacer()
        }
    }
}
