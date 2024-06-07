import SwiftUI

struct MonitorRowView: View {
    var monitor: Monitor
    var body: some View {
        HStack {
            Image(systemName: "eye.square.fill")
                .foregroundColor(Color("secondary"))
                .padding()

            Text(monitor.title?.prefix(13) ?? "Unknown")
                .font(.headline)
                .foregroundColor(Color("secondary"))
                .lineLimit(1)
                .padding()

            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("border"), lineWidth: 2)
        )
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}
