//
//  PasswordChangedRequest.swift
//  Propromo
//
//  Created by Stevan Vlajic on 06.06.24.
//

import Foundation
import SwiftUI

struct PasswordChangedRequest: Encodable {
    
    private (set) var newPassword: String = ""
    private (set) var confirmNewPassword: String = ""
    private (set) var oldPassword: String = ""
    private (set) var email: String = ""

    mutating func dataChanged(oldPassword: String? = nil, confirmNewPassword: String? = nil, newPassword: String? = nil, email: String? = nil) {
        if let val = newPassword {
            self.newPassword = val
        }
        if let val = oldPassword {
            self.oldPassword = val
        }
        if let val = email {
            self.email = val
        }
        if let val = confirmNewPassword {
            self.confirmNewPassword = val
        }
    }
    init(){}
}
