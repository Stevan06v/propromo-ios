import SwiftUI
import Alamofire

class RegisterService {
    let url = "http://propromo.test/api/v1/users"
    
    // https://www.tutorialspoint.com/what-is-a-completion-handler-in-swift
    func register(registerRequest: RegisterRequest, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
            
            AF.request(url,
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
