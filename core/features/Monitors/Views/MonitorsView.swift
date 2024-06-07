import SwiftUI

struct MonitorsView: View {
    @ObservedObject var monitorsViewModel: MonitorsViewModel = .init()

    var body: some View {
        MonitorListView(monitors: monitorsViewModel.monitorsModel.monitors)
            .task {
                monitorsViewModel.getMonitors()
            }
    }
}
