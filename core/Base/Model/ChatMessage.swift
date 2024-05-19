//
//  ChatMessage.swift
//  Propromo
//
//  Created by Jonas Fröller on 16.05.24.
//

import Foundation

struct ChatMessage: Decodable, Identifiable, Hashable {
    private (set) var id: String? = ""
    private (set) var email: String? = ""
    private (set) var timestamp: String? = ""
    private (set) var text: String? = ""

    init(){}
}
