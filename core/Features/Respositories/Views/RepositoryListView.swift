//
//  Repositories.swift
//  Propromo
//
//  Created by Stevan Vlajic on 25.04.24.
//

import SwiftUI

struct RepositoryListView: View {

    var repositories: [Repository]
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(0 ..< self.repositories.count) { index in
                    var repository: Repository = self.repositories[index]
                    NavigationLink(repository.name!, value: repository)
                }.navigationDestination(for: Repository.self) { repository in
                    RepositoryDetailsView(repository: repository)
                }
            }
        }.navigationTitle("Repositories")
    }
}
