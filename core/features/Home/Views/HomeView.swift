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
    @State private var monitorUrl = ""

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
                
                Button(action: {
                    router.navigate(to: .joinMonitor)
                }, label: {
                    Text("Join")
                })
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
        HomeView()
    }
}
