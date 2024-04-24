import SwiftUI
import Combine


struct ContentView: View {
    @EnvironmentObject var router: Router
    @AppStorage("AUTH_KEY") var authenticated: Bool = false
    @SceneStorage("selectedView") var selectedView: String?

    
    
    var body: some View {
        ZStack{
            if !authenticated {
                RegistrationView(router: router)
            } else {
                TabView(selection: $selectedView) {
                    VStack {
                        HomeView(router: router)
                    }.tabItem() {
                        Label("Home", systemImage: "house")
                    }.padding()
                        .tag(HomeView.tag)
                    VStack {
                        MonitorsView()
                    }.tabItem() {
                        Label("Monitors", systemImage: "square.stack.3d.up")
                    }.tag(MonitorsView.tag)
                    
                    VStack {
                        Text("Chat")
                    }.tabItem() {
                        Label("Chat", systemImage: "text.bubble.fill")
                    }
                    VStack {
                        Text("Settings")
                    }.tabItem() {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let router = Router()
        ContentView().environmentObject(router)
    }
}
