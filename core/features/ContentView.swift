//
//  ContentView.swift
//  propromo
//
//  Created by Stevan Vlajic on 08.02.24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedView = 1 // -1

    var body: some View {
        NavigationStack {
            switch selectedView {
                case 0:
                    LogInView(selectedView: $selectedView)
                case 1:
                    TabView {
                        VStack {
                            HomeView(selectedView: $selectedView)
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
                default:
                    RegisterView(selectedView: $selectedView)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
