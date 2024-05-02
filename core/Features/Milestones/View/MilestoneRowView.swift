import SwiftUI

struct MilestoneRowView: View {
    var milestone: Milestone
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(milestone.title ?? "Untitled")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Progress: \(milestone.progress ?? "Unknown")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(8)
    }
}
