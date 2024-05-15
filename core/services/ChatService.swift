//
//  ChatService.swift
//  Propromo
//
//  Created by Jonas Fröller on 02.05.24.
//

import Foundation
import Alamofire
import Starscream

struct ChatLoginRequest: Encodable {
    let email: String
    let password: String
    let monitorId: String
}

class ChatService {
    let url = "https://propromo-chat-c575fve9ssfr.deno.dev"
    
    func login(loginRequest: ChatLoginRequest, completion: @escaping (Result<String, Error>) -> Void) { // returns token for chat
        AF.request(url + "/login",
                   method: .post,
                   parameters: loginRequest, // body as json
                   encoder: JSONParameterEncoder.default).response { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            guard let responseData = response.data else {
                let error = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }

            guard let responseString = String(data: responseData, encoding: .utf8) else {
                let error = NSError(domain: "ChatLoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data could not be converted to a string"])
                completion(.failure(error))
                return
            }

            completion(.success(responseString))
        }
    }
}
