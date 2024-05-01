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

    
    init(){}
}
