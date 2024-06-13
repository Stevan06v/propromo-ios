import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var joinMonitorViewModel: JoinMonitorViewModel
    static let tag: String? = "Home"

    @SceneStorage("selectedView") var selectedView: String?

    init() {
        _joinMonitorViewModel = ObservedObject(wrappedValue: JoinMonitorViewModel())
    }

    var body: some View {
        VStack(alignment: .center) {
            WebView(svgString: SVGIcons.logo())
                .frame(height: 380)

            Text("Propromo")
                .bold()
                .font(.largeTitle)
                .textCase(.uppercase)

            Text("Project Progress Monitoring")
                .bold()
                .font(.subheadline)
                .foregroundStyle(Color.gray)
                .textCase(.uppercase)
                .padding(.bottom, 20)

            Text("Works with:")
                .bold()
                .font(.caption)
                .foregroundStyle(Color.gray)
                .textCase(.uppercase)

            HStack {
                Spacer()
                WebView(svgString: SVGIcons.github(size: 150))
                    .frame(width: 150)
                    .padding(.leading, 105)
                Spacer()
            }.padding(.bottom, 40)

            HStack {
                TextField("Monitor-ID", text: Binding(get: {
                    joinMonitorViewModel.monitorHash
                }, set: {
                    joinMonitorViewModel.dataChanged(monitorHash: $0)
                }))
                .textFieldStyle(.roundedBorder)

                Button(action: {
                    joinMonitorViewModel.joinMonitor()
                }, label: {
                    Text("Join")
                }).buttonStyle(.borderedProminent)
                    .alert(isPresented: $joinMonitorViewModel.showAlert) {
                        Alert(
                            title: Text("Joining Notification"),
                            message: Text(joinMonitorViewModel.message)
                        )
                    }
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 15)

            Spacer()
        }
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
