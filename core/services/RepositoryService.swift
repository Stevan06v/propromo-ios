import Alamofire
import Foundation
import SwiftUI

class RepositoryService {
    func getRepositoriesBy(monitor: Monitor, completion: @escaping (Result<RepositoryResponse, Error>) -> Void) {
        // jo eh
        let url = monitor.type! == "ORGANIZATION" ? "https://rest-microservice.onrender.com/v1/github/orgs/\(monitor.organization_name!)/projects/\(monitor.project_identification!)/repositories/milestones/issues?rootPageSize=10&milestonesPageSize=10&issuesPageSize=100&issues_states=open,closed"
            : "https://rest-microservice.onrender.com/v1/github/users/\(monitor.login_name!)/projects/\(monitor.project_identification!)/repositories/milestones/issues?rootPageSize=10&milestonesPageSize=10&issuesPageSize=100&issues_states=open,closed"

        let headers: HTTPHeaders = [
            .authorization(bearerToken: monitor.pat_token!),
        ]

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).response { response in
            if let error = response.error {
                print(error)
                completion(.failure(error))
                return
            }

            guard let responseData = response.data else {
                let error = NSError(domain: "RepositoryService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }
            do {
                let repositoryResponse = try JSONDecoder().decode(RepositoryResponse.self, from: responseData)
                completion(.success(repositoryResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func getRepositoriesByMonitorId(monitorId: Int, completion: @escaping (Result<RepositoryResponse, Error>) -> Void) {
        AF.request(Environment.Services.WEBSITE_API("repositories/\(monitorId)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { response in
            if let error = response.error {
                print(error)
                completion(.failure(error))
                return
            }

            guard let responseData = response.data else {
                let error = NSError(domain: "RepositoryService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }

            do {
                let repositoryResponse = try JSONDecoder().decode(RepositoryResponse.self, from: responseData)
                completion(.success(repositoryResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
