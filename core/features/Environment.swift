import Foundation

public enum Environment {
    static let isDebug: Bool = {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }()

    enum Services {
        static func WEBSITE(_ path: String) -> String {
            return "https://propromo-d08144c627d3.herokuapp.com/\(path)"
        }
        static func WEBSITE_API(_ path: String) -> String {
            return "https://propromo-d08144c627d3.herokuapp.com/api/v1/\(path)"
        }
        
        static func MICROSERVICE_API(_ path: String) -> String {
            return "https://rest-microservice.onrender.com/v1/\(path)"
        }
        static func MICROSERVICE_API_GITHUB(_ path: String) -> String {
            return "https://rest-microservice.onrender.com/v1/github/\(path)"
        }
        static func MICROSERVICE_API_GITHUB_ORGANIZATION(_ path: String) -> String {
            return "https://rest-microservice.onrender.com/v1/github/orgs/\(path)"
        }
        static func MICROSERVICE_API_GITHUB_USER(_ path: String) -> String {
            return "https://rest-microservice.onrender.com/v1/github/users/\(path)"
        }
    }
}
