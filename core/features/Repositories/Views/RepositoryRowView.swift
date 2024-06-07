import SwiftUI

struct RepositoryRowView: View {
    var repository: Repository

    var body: some View {
        HStack {
            Image(systemName: "tray.full")
                .foregroundColor(Color("secondary"))
                .padding()

            // Limit the length of the title/name to 13 characters
            Text(repository.name?.prefix(13) ?? "Unknown")
                .font(.headline)
                .foregroundColor(Color("secondary"))
                .lineLimit(1) // Display the text in a single line
                .padding()

            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading) // Ensure the HStack takes up the entire width
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("border"), lineWidth: 2)
        )
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}
