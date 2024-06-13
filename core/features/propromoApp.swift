import Foundation
import SwiftUI

@main
struct propromoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    AppDelegate.orientationLock = .portrait
                }
            // .onDisappear {
            //    AppDelegate.orientationLock = .all
            // }
        }
    }
}
