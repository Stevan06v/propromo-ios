//
//  MonitorListView.swift
//  Propromo
//
//  Created by Stevan Vlajic on 01.05.24.
//

import SwiftUI

struct MonitorListView: View {
    var monitors: [Monitor]
    var body: some View {
        NavigationSplitView {
            List(monitors, id: \.id){ monitor in
                NavigationLink {
                    MonitorDetailsView(monitor: monitor)
                } label: {
                    MonitorRowView(monitor: monitor)
                }
            }.navigationTitle("Monitors")
        } detail: {
            Text("Select a monitor")
        }
       
    }
}


