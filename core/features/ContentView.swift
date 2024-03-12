//
//  ContentView.swift
//  propromo
//
//  Created by Stevan Vlajic on 08.02.24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedView = -1

    var body: some View {
        NavigationStack {
            switch selectedView {
                case 0:
                    LogInView(selectedView: $selectedView)
                case 1:
                    Text("Home")
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
