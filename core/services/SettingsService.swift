//
//  SettingsService.swift
//  Propromo
//
//  Created by Stevan Vlajic on 09.06.24.
//

import Alamofire
import Foundation
import SwiftUI

class SettingsService {
    let url = "https://propromo-d08144c627d3.herokuapp.com/api/v1/users/update"

    func updateEmail(emailChangedRequest: EmailChangedRequest, completion: @escaping (Result<EmailChangedReponse, Error>) -> Void) {
        let url = "\(self.url)/email"

        AF.request(url,
                   method: .put,
                   parameters: emailChangedRequest,
                   encoder: JSONParameterEncoder.default).response { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }

            guard let responseData = response.data else {
                let error = NSError(domain: "SettingsService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }

            do {
                let emailChangedResponse = try JSONDecoder().decode(EmailChangedReponse.self, from: responseData)
                completion(.success(emailChangedResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func updatePassword(passwordChangedRequest: PasswordChangedRequest, completion: @escaping (Result<PasswordChangedReponse, Error>) -> Void) {
        let url = "\(self.url)/password"

        AF.request(url,
                   method: .put,
                   parameters: passwordChangedRequest,
                   encoder: JSONParameterEncoder.default).response { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }

            guard let responseData = response.data else {
                let error = NSError(domain: "SettingsService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }

            do {
                let passwordChangedResponse = try JSONDecoder().decode(PasswordChangedReponse.self, from: responseData)
                completion(.success(passwordChangedResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
