//
//  MonitorRowView.swift
//  Propromo
//
//  Created by Stevan Vlajic on 01.05.24.
//

import SwiftUI

struct MonitorRowView: View {
    var monitor: Monitor
    var body: some View {
        HStack{
            Text(monitor.title!)
            Spacer()
        }
    }
}






