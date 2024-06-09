import SwiftUI

struct MilestoneListView: View {
    var milestones: [Milestone]

    var body: some View {
        NavigationSplitView {
            ScrollView {
                if milestones.isEmpty {
                    Text("No milestones available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    VStack(spacing: 10) {
                        ForEach(milestones, id: \.id) { milestone in
                            NavigationLink(destination: MilestoneDetailView(milestone: milestone)) {
                                MilestoneRowView(milestone: milestone)
                            }
                            .buttonStyle(PlainButtonStyle()) // Remove default button styling
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Milestones")
        } detail: {
            Text("Select a milestone")
        }
    }
}
