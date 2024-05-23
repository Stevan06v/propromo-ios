import Foundation

struct ChatMessage: Decodable, Identifiable, Hashable {
    private (set) var id: String? = ""
    private (set) var email: String? = ""
    private (set) var timestamp: String? = ""
    private (set) var text: String? = ""
    
    init(){}
    
    init(text: String, email: String) {
        self.text = text
        self.email = email
    }
}
