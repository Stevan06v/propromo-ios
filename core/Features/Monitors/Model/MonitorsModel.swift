//
//  MonitorsModel.swift
//  Propromo
//
//  Created by Stevan Vlajic on 25.04.24.
//

import Foundation

struct MonitorsModel {
    private (set) var monitors: [Monitor] = []
    
    mutating func setMonitors(monitors: [Monitor]){
        self.monitors = monitors
    }
    
    mutating func setMonitorRepositories(monitor: Monitor, repositories: [Repository]) {
        if let index = self.monitors.firstIndex(where: { $0.monitor_hash == monitor.monitor_hash }) {
            var updatedMonitor = self.monitors[index]
            updatedMonitor.setRepositories(repositories: repositories)
            self.monitors[index] = updatedMonitor
        } else {
            print("Monitor not found with hash: \(monitor.monitor_hash)")
        }
    }
    
    init(){}
}
