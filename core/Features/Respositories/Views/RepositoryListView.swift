import SwiftUI

struct RepositoryListView: View {
    var repositories: [Repository]
    
    var body: some View {
        NavigationSplitView {
            if repositories.isEmpty {
                Text("No repositories available")
                    .foregroundColor(.secondary)
            } else {
                List(repositories, id: \.id) { repository in
                    NavigationLink {
                        RepositoryDetailsView(repository: repository)
                    } label: {
                        RepositoryRowView(repository: repository)
                    }
                }
            }
        }detail: {
            Text("Select a repository")
        }
    }
}
