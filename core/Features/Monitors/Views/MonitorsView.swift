import SwiftUI

struct MonitorsView: View {
    @ObservedObject var monitorsViewModel: MonitorsViewModel = MonitorsViewModel()
    
    var body: some View {
        MonitorListView(monitors: monitorsViewModel.monitorsModel.monitors)
            .task {
                monitorsViewModel.getMonitors()
            }
    }
}

