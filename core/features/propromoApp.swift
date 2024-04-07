import SwiftUI
import Foundation

@main
struct propromoApp: App {
    @ObservedObject var router: Router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                            case .home:
                                HomeView()
                            case .login:
                                LogInView()
                            case .joinMonitor:
                                JoinMonitorView()
                            case .registration:
                                RegistrationView()
                            case .chooseProvider:
                                ChooseProviderView()
                            default:
                                HomeView()
                        }
                            
                    }
            }
            .environmentObject(router)
        }
    }
}
