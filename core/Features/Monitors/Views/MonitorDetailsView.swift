import SwiftUI

struct MonitorDetailsView: View {

    var monitor: Monitor
    @ObservedObject var monitorsViewModel: MonitorsViewModel = MonitorsViewModel()

    
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
            RepositoryListView(repositories: monitor.repositories)
                .task {
                    monitorsViewModel.getRepositories(monitor: monitor)
                }
        }
        .padding()
    }
}
