import SwiftUI

struct MonitorDetailsView: View {
    var monitor: Monitor
    @ObservedObject var monitorsViewModel: MonitorsViewModel = MonitorsViewModel()
    
    var body: some View {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text(monitor.title ?? "Untitled")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text(monitor.short_description ?? "No description available")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Divider()
                    
                    HStack {
                        Text("Type:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(monitor.type ?? "Unknown")
                            .foregroundColor(.primary)
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                0
                            }
                    }
                    
                    HStack {
                        Text("Monitor Hash:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("\(monitor.monitor_hash)")
                            .foregroundColor(.primary)
                            .alignmentGuide(HorizontalAlignment.leading) { _ in
                                0 // Align to leading edge of parent
                            }
                    }
                    
                    HStack {
                        if let loginName = monitor.login_name {
                            Text("Login Name:")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(loginName)
                                .foregroundColor(.primary)
                                .alignmentGuide(HorizontalAlignment.leading) { _ in
                                    0 // Align to leading edge of parent
                                }
                        } else if let organizationName = monitor.organization_name {
                            Text("Organization Name:")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(organizationName)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .alignmentGuide(HorizontalAlignment.leading) { _ in
                                    0 // Align to leading edge of parent
                                }
                        } else {
                            Text("Unknown")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .alignmentGuide(HorizontalAlignment.leading) { _ in
                                    0 // Align to leading edge of parent
                                }
                        }
                    }
                    
                    Divider()
                    
                    RepositoryListView(repositories: monitorsViewModel.repositoryModel.repositories).task {
                        monitorsViewModel.getRepositoriesByMonitorId(monitorId: monitor.id!)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .padding(.horizontal, 20)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
    
    
    struct MonitorDetailsView_Previews: PreviewProvider {
        static var monitor: Monitor = {
            Monitor(id: 1,
                    type: ["Type A", "Type B", "Type C"].randomElement(),
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
}
