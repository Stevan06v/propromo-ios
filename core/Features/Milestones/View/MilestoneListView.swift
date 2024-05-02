//
//  MilestoneListView.swift
//  Propromo
//
//  Created by Stevan Vlajic on 02.05.24.
//

import SwiftUI

struct MilestoneListView: View {
    var milestones: [Milestone]
    
    var body: some View {
        NavigationSplitView {
            List(milestones, id: \.id){ milestone in
                NavigationLink {
                    MilestoneDetailView(milestone: milestone)
                } label: {
                    MilestoneRowView(milestone: milestone)
                }
            }
        }detail: {
            Text("Select a monitor")
        }
    }
}


