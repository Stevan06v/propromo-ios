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
        MonitorListView(monitors: monitorsViewModel.monitorsModel.monitors)
            .task {
                monitorsViewModel.getMonitors()
            }
    }
}

