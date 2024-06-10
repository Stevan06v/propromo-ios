//
//  PasswordChangedResponse.swift
//  Propromo
//
//  Created by Stevan Vlajic on 06.06.24.
//

import Foundation

struct PasswordChangedReponse: Decodable {
    private(set) var success: Bool = false
    private(set) var message: String = ""
    private(set) var error: String?

    init() {}
}
