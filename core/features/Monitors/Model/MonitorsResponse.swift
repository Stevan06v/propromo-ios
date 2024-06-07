import Foundation

struct MonitorsResponse: Decodable {
    private(set) var success: Bool = false
    private(set) var monitors: [Monitor] = []

    init() {}
}
