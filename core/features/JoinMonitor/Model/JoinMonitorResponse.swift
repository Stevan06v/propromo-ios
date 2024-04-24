//
//  JoinMonitorResponse.swift
//  Propromo
//
//  Created by Stevan Vlajic on 24.04.24.
//

import Foundation

struct JoinMonitorResponse: Decodable {
    private (set) var success: Bool = false
    private (set) var message: String = ""
    private (set) var monitor: Monitor = Monitor()
    
    init(){}
}
