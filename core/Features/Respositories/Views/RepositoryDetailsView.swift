//
//  RepositoryDetailsView.swift
//  Propromo
//
//  Created by Stevan Vlajic on 25.04.24.
//

import SwiftUI

struct RepositoryDetailsView: View {
    var repository: Repository
    
    var body: some View {
        Text(repository.name!)
    }
}

