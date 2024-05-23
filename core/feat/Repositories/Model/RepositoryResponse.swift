//
//  RepositoryResponse.swift
//  Propromo
//
//  Created by Stevan Vlajic on 25.04.24.
//

import Foundation

struct RepositoryResponse: Decodable {
    
    private (set) var success: Bool = false
    private (set) var repositories: [Repository] = []
    
    init(){}
}
