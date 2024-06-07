import SwiftUI

struct MilestoneDetailView: View {
    var milestone: Milestone

    var body: some View {
        let progress = Float(milestone.progress ?? "0") ?? 0
        let progressString = String(progress.rounded())

        let progressBarColor: Color

        switch progress {
        case 78 ... 100:
            progressBarColor = .green
        case 50 ..< 78:
            progressBarColor = .orange
        default:
            progressBarColor = .red
        }

        let description = milestone.description ?? "No description available"
        let truncatedDescription = description.count > 100 ? String(description.prefix(100)) + "..." : description

        return VStack(alignment: .leading, spacing: 20) {
            Text(milestone.title ?? "Untitled")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text(truncatedDescription)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(nil)

            HStack {
                Text("State:")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(milestone.state ?? "Unknown")
                    .font(.body)
                    .foregroundColor(.secondary)
            }

            HStack(spacing: 10) {
                Spacer()

                VStack {
                    Text("Open")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                    Text("\(milestone.open_issues_count)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .padding(8)
                        .frame(width: 100, height: 100)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 4))
                }

                Spacer()

                VStack {
                    Text("Closed")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                    Text("\(milestone.closed_issues_count)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(8)
                        .frame(width: 100, height: 100)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 4))
                }

                Spacer()
            }

            HStack {
                ProgressView(value: Double(progress), total: 100)
                    .accentColor(progressBarColor)

                Text("\(progressString)%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
    }
}
