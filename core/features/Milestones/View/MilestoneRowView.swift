import SwiftUI

struct MilestoneRowView: View {
    var milestone: Milestone

    var body: some View {
        let progress = Float(milestone.progress ?? "0") ?? 0
        let progressString = String(progress.rounded())

        let borderColor: Color

        switch progress {
        case 78 ... 100:
            borderColor = .green
        case 50 ..< 78:
            borderColor = .orange
        default:
            borderColor = .red
        }

        return HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(milestone.title ?? "Untitled")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                HStack {
                    ProgressView(value: Double(progress), total: 100)
                        .accentColor(borderColor)

                    Text("\(progressString)%")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("secondaryBackground"))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 2)
        )
        .padding(.horizontal)
    }
}
