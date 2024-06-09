import SwiftUI

struct MonitorListView: View {
    var monitors: [Monitor]

    var body: some View {
        NavigationSplitView {
            ScrollView {
                if monitors.isEmpty {
                    Text("No monitors available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    VStack(spacing: 10) {
                        ForEach(monitors, id: \.id) { monitor in
                            NavigationLink(destination: MonitorDetailsView(monitor: monitor)) {
                                MonitorRowView(monitor: monitor)
                            }
                            .buttonStyle(PlainButtonStyle()) // Remove default button styling
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Monitors")
        } detail: {
            Text("Select a monitor")
        }
    }
}
