//
//  Monitor.swift
//  Propromo
//
//  Created by Stevan Vlajic on 24.04.24.
//

import Foundation


struct Monitor: Decodable, Identifiable, Hashable{
    
    private (set) var id: Int? = 0
    private (set) var type: String? = ""
    private (set) var readme: String? = ""
    private (set) var title: String? = ""
    private (set) var login_name: String? = ""
    private (set) var pat_token: String? = ""
    private (set) var short_description: String? = ""
    private (set) var organization_name: String? = ""
    private (set) var project_identification: Int? = 0
    private (set) var monitor_hash: String = ""
    private (set) var repositories: [Repository] = []
    
    init(){}
    
    mutating public func setRepositories(repositories: [Repository]){
        self.repositories = repositories
    }
}
