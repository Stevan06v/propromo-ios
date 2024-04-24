import SwiftUI
import Alamofire

class MonitorService {
    
    // https://www.tutorialspoint.com/what-is-a-completion-handler-in-swift
    func joinMonitor(joinMonitorRequest: JoinMonitorRequest, completion: @escaping (Result<JoinMonitorResponse, Error>) -> Void) {
                let url = "http://propromo.test/api/v1/join-monitor"
                AF.request(url,
                           method: .post,
                           parameters: joinMonitorRequest,
                           encoder: JSONParameterEncoder.default).response { response in
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
                        let joinMonitorResponse = try JSONDecoder().decode(JoinMonitorResponse.self, from: responseData)
                        completion(.success(joinMonitorResponse))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        
        func getMonitorsByEmail(email: String, completion: @escaping (Result<MonitorsResponse, Error>)->Void) {
            let url = "http://propromo.test/api/v1/monitors/\(email)"
            
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
