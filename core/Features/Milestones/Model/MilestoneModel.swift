//
//  MilestoneModel.swift
//  Propromo
//
//  Created by Stevan Vlajic on 02.05.24.
//

import Foundation

struct MilestoneModel {
    private (set) var milestones: [Milestone] = []
    
    mutating func setMilestones(milestones: [Milestone]){
        self.milestones = milestones
    }

    
    init(){}
}
