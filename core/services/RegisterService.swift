import Alamofire
import SwiftUI

class RegisterService {
    // https://www.tutorialspoint.com/what-is-a-completion-handler-in-swift
    func register(registerRequest: RegisterRequest, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        AF.request(Environment.Services.WEBSITE_API("users"),
                   method: .post,
                   parameters: registerRequest,
                   encoder: JSONParameterEncoder.default).response { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }

            guard let responseData = response.data else {
                let error = NSError(domain: "RegisterService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }

            do {
                let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: responseData)
                completion(.success(registerResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
