import Combine
import SwiftUI

struct ContentView: View {
    @AppStorage("AUTH_KEY") var authenticated: Bool = false
    @SceneStorage("selectedView") var selectedView: String?

    @ObservedObject var viewModel: ViewModel

    init() {
        _viewModel = ObservedObject(wrappedValue: ViewModel())
    }

    var body: some View {
        if authenticated && viewModel.showAuthenticationView {
            AuthenticationView().environmentObject(viewModel)
        } else {
            TabView(selection: $selectedView) {
                VStack {
                    HomeView()
                }.tabItem {
                    Label("Home", systemImage: "house")
                }.padding()
                VStack {
                    MonitorsView()
                }.tabItem {
                    Label("Monitors", systemImage: "square.stack.3d.up")
                }
                VStack {
                    ChatView()
                }.tabItem {
                    Label("Chat", systemImage: "text.bubble.fill")
                }
                VStack {
                    Text("Settings")
                }.tabItem {
                    Label("Settings", systemImage: "gear")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
