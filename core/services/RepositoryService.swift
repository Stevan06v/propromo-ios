//
//  MilestoneService.swift
//  Propromo
//
//  Created by Stevan Vlajic on 24.04.24.
//

import Foundation
import Alamofire
import SwiftUI

class RepositoryService {
    
    func getMonitorsByEmail(monitor: Monitor, completion: @escaping (Result<MonitorsResponse, Error>)->Void) {
        let url = "https://rest-microservice.onrender.com/v1/github/orgs/"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { response in
            if let error = response.error {
                print(error)
                completion(.failure(error))
                return
            }
            
            guard let responseData = response.data else {
                let error = NSError(domain: "MonitorService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response data is nil"])
                completion(.failure(error))
                return
            }
            
            do {
                let monitorsResponse = try JSONDecoder().decode(MonitorsResponse.self, from: responseData)
                completion(.success(monitorsResponse))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
