//
//  MonitorsView.swift
//  Propromo
//
//  Created by Stevan Vlajic on 24.04.24.
//

import SwiftUI

struct MonitorsView: View {
    
    static let tag: String? = "Monitors"
    @ObservedObject var monitorsViewModel: MonitorsViewModel = MonitorsViewModel()
    

    var body: some View {
        NavigationStack {
                List(monitorsViewModel.monitorsResponse.monitors){ monitor in
                    NavigationLink(monitor.title!, value: monitor)
                }.navigationDestination(for: Monitor.self) { monitor in
                    MonitorDetails(monitor: monitor)
                }
            }.navigationTitle("Test")
            .task {
                monitorsViewModel.getMonitors()
            }.navigationTitle("Monitors")
    }

}


