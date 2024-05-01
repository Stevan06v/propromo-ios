//
//  RepositoryRowView.swift
//  Propromo
//
//  Created by Stevan Vlajic on 02.05.24.
//

import SwiftUI

struct RepositoryRowView: View {
    var repository: Repository
    var body: some View {
        HStack{
            Text(repository.name!)
            Spacer()
        }
    }
}

