    import SwiftUI

    struct RepositoryListView: View {
        var repositories: [Repository]

        var body: some View {
            NavigationView {
                if repositories.isEmpty {
                    Text("No repositories available")
                        .foregroundColor(.secondary)
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(repositories, id: \.id) { repository in
                                NavigationLink(destination: RepositoryDetailsView(repository: repository)) {
                                    RepositoryRowView(repository: repository)
                                        .frame(maxWidth: .infinity) // Ensure full width
                                }
                                .buttonStyle(PlainButtonStyle()) // Remove default button styling
                            }
                        }
                        .padding()
                    }
                    .navigationTitle(Text("Repositories"))
        
                    .navigationBarTitleDisplayMode(.automatic)
                }
            }
        }
    }
