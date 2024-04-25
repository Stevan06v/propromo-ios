//
//  Milestone.swift
//  Propromo
//
//  Created by Stevan Vlajic on 25.04.24.
//

import Foundation

struct Milestone: Decodable, Hashable {
    
    private (set) var number: Int? = 0
    private (set) var description: String? = ""
    private (set) var dueOn: String? = ""
    private (set) var progressPercentage: Double? = 0.0
    private (set) var title: String? = ""
    private (set) var state: String? = ""
    private (set) var url: String? = ""
    
}

