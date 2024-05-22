import SwiftUI

struct MonitorDetailsView: View {
    var monitor: Monitor
    @ObservedObject var monitorsViewModel: MonitorsViewModel = MonitorsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(monitor.title?.uppercased() ?? "Untitled")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("primary"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 10) {
                    Image(systemName: "info.circle")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1) // Add shadow effect
                    
                    Text(monitor.short_description ?? "No description available")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2) // Limit the number of lines to 2
                        .padding(.trailing, 10) // Add padding to the trailing edge
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("border"), lineWidth: 2)
                )
            }
            .padding()
            
            RepositoryListView(repositories: monitorsViewModel.repositoryModel.repositories)
                .task {
                    monitorsViewModel.getRepositoriesByMonitorId(monitorId: monitor.id!)
                }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        Spacer()
    }
}

struct MonitorDetailsView_Previews: PreviewProvider {
    static var monitor: Monitor = {
        Monitor(id: 1,
                type: ["USER", "ORGANIZATION"].randomElement(),
                readme: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                title: "Random Monitor",
                login_name: "random_user",
                pat_token: "random_token",
                short_description: "This is a random monitor.",
                organization_name: "Random Org",
                project_identification: Int.random(in: 1000...9999),
                monitor_hash: UUID().uuidString,
                repositories: [])
    }()
    
    static var previews: some View {
        MonitorDetailsView(monitor: monitor)
    }
}
