//
//  MilestoneResponse.swift
//  Propromo
//
//  Created by Stevan Vlajic on 02.05.24.
//

import Foundation
import Foundation


struct MilestoneResponse: Decodable {
    private (set) var success: Bool = false
    private (set) var milestones: [Milestone] = []
    
    init(){}
}
