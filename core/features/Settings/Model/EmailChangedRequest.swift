//
//  EmailChangedRequest.swift
//  Propromo
//
//  Created by Stevan Vlajic on 06.06.24.
//

import Foundation

import Foundation
import SwiftUI

struct EmailChangedRequest: Encodable {
    private(set) var newEmail: String = ""
    private(set) var email: String = ""

    mutating func dataChanged(newEmail: String? = nil, email: String? = nil) {
        if let val = newEmail {
            self.newEmail = val
        }
        if let val = email {
            self.email = val
        }
    }
}
