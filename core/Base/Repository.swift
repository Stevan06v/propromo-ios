//
//  Repository.swift
//  Propromo
//
//  Created by Stevan Vlajic on 25.04.24.
//

import Foundation

struct Repository: Decodable, Identifiable, Hashable{
    private (set) var id: Int = 0
    private (set) var name: String? = ""
    private (set) var description: String? = ""
    private (set) var milestones: MileStoneObj = MileStoneObj()

    init(){}
}

struct MileStoneObj: Decodable, Hashable{
    private (set) var totalCount: Int? = 0
    private (set) var nodes: [Milestone] = []
}
