import Foundation

struct MonitorsModel {
    private(set) var monitors: [Monitor] = []

    mutating func setMonitors(monitors: [Monitor]) {
        self.monitors = monitors
    }

    init() {}
}
