import Foundation
import SwiftUI

struct LoginRequest: Encodable {
    private(set) var email: String = ""
    private(set) var password: String = ""

    mutating func dataChanged(email: String? = nil, password: String? = nil) {
        if let val = email {
            self.email = val
        }
        if let val = password {
            self.password = val
        }
    }
}
