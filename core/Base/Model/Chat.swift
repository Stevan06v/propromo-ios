//
//  Chat.swift
//  Propromo
//
//  Created by Jonas Fröller on 16.05.24.
//

import Foundation

struct Chat: Decodable, Identifiable, Hashable {
    private (set) var id: String? = ""
    private (set) var login_name: String? = ""
    private (set) var short_description: String? = ""
    private (set) var monitor_hash: String = ""
    private (set) var messages: [ChatMessage]? = []

    mutating public func setMessages(messages: [ChatMessage]){
        self.messages = messages
    }
    
    init(){}
    
    init(id: String?,
         monitor_hash: String,
         login_name: String?,
         short_description: String?,
         messages: [ChatMessage]? = []) {
        
        self.id = id
        self.login_name = login_name
        self.short_description = short_description
        self.monitor_hash = monitor_hash
        self.messages = messages
    }
}
