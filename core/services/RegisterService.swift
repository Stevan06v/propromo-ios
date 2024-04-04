import Foundation

class RegisterService {
    let dataUrl = "http://propromo.test/api/v1/users"
    
    public func makeRegisterRequest() async -> Bool {
        let registerUrl = URL(string: dataUrl)!;
        
        var request = URLRequest(url: registerUrl)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "auth_type":"PROPROMO",
            "name": "Jack & Jill",
            "email": "stevanvlajic@gmail.com"
            "password": "StevanVlajic"
        ]
        
        request.httpBody = parameters.percentEncoded()

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
        }
        task.resume()
    }
}



