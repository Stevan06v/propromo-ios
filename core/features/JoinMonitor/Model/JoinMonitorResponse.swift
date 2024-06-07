import Foundation

struct JoinMonitorResponse: Decodable {
    private(set) var success: Bool = false
    private(set) var message: String = ""
    private(set) var monitor: Monitor = .init()

    init() {}
}
