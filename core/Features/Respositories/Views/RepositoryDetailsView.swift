//
//  RepositoryDetailsView.swift
//  Propromo
//
//  Created by Stevan Vlajic on 02.05.24.
//

import SwiftUI

struct RepositoryDetailsView: View {
    var repository: Repository
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) { 
                Text(repository.name ?? "Untitled")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                    .multilineTextAlignment(.center)
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .padding(.horizontal, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .top) // Align VStack at the top
    }
}

