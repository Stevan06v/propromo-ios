import SwiftUI
import Combine


struct ContentView: View {
    @EnvironmentObject var router: Router
    @AppStorage("AUTH_KEY") var authenticated: Bool = false
    
    var body: some View {
        ZStack{
            if !authenticated {
                RegistrationView(router: router)
            } else {
                TabView {
                    VStack {
                        HomeView()
                    }.tabItem() {
                        Label("Home", systemImage: "house")
                    }.padding()
                    VStack {
                        Text("Projects")
                    }.tabItem() {
                        Label("Projects", systemImage: "square.stack.3d.up")
                    }.badge(69)
                    
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
