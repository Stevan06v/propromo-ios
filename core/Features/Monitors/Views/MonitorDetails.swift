import SwiftUI

struct MonitorDetails: View {
    
    var monitor: Monitor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(monitor.title!)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            Text(monitor.short_description ?? "No description available")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
}
