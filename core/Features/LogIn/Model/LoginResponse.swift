//
//  LoginResponse.swift
//  Propromo
//
//  Created by Stevan Vlajic on 08.04.24.
//

import Foundation

struct LoginReponse: Decodable {
    
    private (set) var success: Bool = false
    private (set) var message: String = ""
    private (set) var user: User = User()
    
    init(){}
}
