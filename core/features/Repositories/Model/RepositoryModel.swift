//
//  RepositoryModel.swift
//  Propromo
//
//  Created by Stevan Vlajic on 01.05.24.
//

import Foundation
struct RepositoryModel {
    private (set) var repositories: [Repository] = []
    
    mutating func setRepositories(repositories: [Repository]){
        self.repositories = repositories
    }

    
    init(){}
}
