import Alamofire
import Foundation
import SwiftUI

class MilestoneService {
    func getMilestonesByRepositoryId(repositoryId: Int, completion: @escaping (Result<MilestoneResponse, Error>) -> Void) {
        let url = "https://propromo-d08144c627d3.herokuapp.com/api/v1/milestones/\(repositoryId)"

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { response in
            if let error = response.error {
                print(error)
                completion(.failure(error))
                return
            }

            guard let responseData = response.data else {
                let error = NSError(domain: "MilestoneService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }

            do {
                let milestoneResponse = try JSONDecoder().decode(MilestoneResponse.self, from: responseData)
                completion(.success(milestoneResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
