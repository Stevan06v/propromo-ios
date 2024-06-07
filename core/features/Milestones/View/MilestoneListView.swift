import SwiftUI

struct MilestoneListView: View {
    var milestones: [Milestone]

    var body: some View {
        NavigationSplitView {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(milestones, id: \.id) { milestone in
                        NavigationLink(destination: MilestoneDetailView(milestone: milestone)) {
                            MilestoneRowView(milestone: milestone)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Milestones")
        } detail: {
            Text("Select a milestone")
        }
    }
}
