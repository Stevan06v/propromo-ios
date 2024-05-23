//
//  RepositoryDetailsView.swift
//  Propromo
//
//  Created by Stevan Vlajic on 02.05.24.
//

import SwiftUI

struct RepositoryDetailsView: View {
    var repository: Repository
    @ObservedObject var monitorsViewModel: MonitorsViewModel = MonitorsViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) { 
                Text(repository.name?.uppercased() ?? "Untitled")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("primary"))
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 10) {
                    Image(systemName: "info.circle")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1) // Add shadow effect
                    
                    Text("Get a quick overview over your ongoing milestones.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2) // Limit the number of lines to 2
                        .padding(.trailing, 10) // Add padding to the trailing edge

                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("border"), lineWidth: 2)
                )
                
                
                
                MilestoneListView(milestones: monitorsViewModel.milestoneModel.milestones)
                    .task {
                        monitorsViewModel.getMilestonesByRepositoryId(repositoryId: repository.id)
                    }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .padding(.horizontal, 20)
            
        }
        .frame(maxWidth: .infinity, alignment: .top) // Align VStack at the top
    }
}

