//
//  RepositoryResponse.swift
//  Propromo
//
//  Created by Stevan Vlajic on 25.04.24.
//

import Foundation

struct RepositoryResponse: Decodable {
    
    private (set) var data: DataObj = DataObj()
    
    init(){}
}

struct DataObj: Decodable {
    private (set) var organization: OrganizationObj = OrganizationObj()
    private (set) var user: UserObj? = UserObj()

}

struct OrganizationObj: Decodable {
    private (set) var projectV2: ProjectV2Obj = ProjectV2Obj()
    
}

struct UserObj: Decodable {
    private (set) var projectV2: ProjectV2Obj = ProjectV2Obj()

}
struct RepositoryObj: Decodable {
    private (set) var nodes: [Repository] = []
}

struct ProjectV2Obj: Decodable {
    private (set) var repositories: RepositoryObj = RepositoryObj()
}
