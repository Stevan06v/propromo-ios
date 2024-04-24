//
//  MonitorsResponse.swift
//  Propromo
//
//  Created by Stevan Vlajic on 24.04.24.
//

import Foundation


struct MonitorsResponse: Decodable {
    private (set) var success: Bool = false
    private (set) var monitors: [Monitor] = []
    
    init(){}
}
