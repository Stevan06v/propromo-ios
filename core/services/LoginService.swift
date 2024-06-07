import Alamofire
import SwiftUI

class LoginService {
    let url = "https://propromo-d08144c627d3.herokuapp.com/api/v1/users/login"

    // https://www.tutorialspoint.com/what-is-a-completion-handler-in-swift
    func register(loginRequest: LoginRequest, completion: @escaping (Result<LoginReponse, Error>) -> Void) {
        AF.request(url,
                   method: .post,
                   parameters: loginRequest,
                   encoder: JSONParameterEncoder.default).response { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }

            guard let responseData = response.data else {
                let error = NSError(domain: "LoginService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }

            do {
                let loginResponse = try JSONDecoder().decode(LoginReponse.self, from: responseData)
                completion(.success(loginResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
