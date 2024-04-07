import Foundation
import SwiftUI

// singleton-pattern
final class Router: ObservableObject{
    
    public enum Destination: Codable, Hashable {
        case home
        case login
        case register
        case joinMonitor
        case registration
        case chooseProvider
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
