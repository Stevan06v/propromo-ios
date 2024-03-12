//
//  TextFieldStyle.swift
//  Propromo
//
//  Created by Jonas Fröller on 09.03.24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var monitorUrl = ""
    @Binding var selectedView: Int

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
                TextField("Monitor-ID", text: $monitorUrl)
                    .textFieldStyle(TextFieldPrimaryStyle())
                
                NavigationLink(destination: JoinMonitorView(selectedView: $selectedView)) {
                    Text("Join")
                        .frame(maxHeight: 40)
                    // TODO: should have no skip option, if navigated to from home or settings
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 15)
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedView: .constant(1))
    }
}
