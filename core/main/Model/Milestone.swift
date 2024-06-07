import Foundation

struct Milestone: Decodable, Identifiable, Hashable {
    private(set) var id: Int? = 0
    private(set) var title: String? = ""
    private(set) var url: String? = ""
    private(set) var state: String? = ""
    private(set) var description: String? = ""
    private(set) var due_on: String? = ""
    private(set) var milestone_id: Int? = 0
    private(set) var open_issues_count: Int = 0
    private(set) var closed_issues_count: Int = 0
    private(set) var progress: String? = ""
    private(set) var repository_id: Int? = 0
    private(set) var created_at: String? = ""
    private(set) var updated_at: String? = ""
    init() {}
}
