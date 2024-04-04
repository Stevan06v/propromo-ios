import Foundation



makeRegisterRequest()


public func makeRegisterRequest() {
    let dataUrl = "http://propromo.test/api/v1/users"
    print("Requesting...")
    let registerUrl = URL(string: dataUrl)!
    
    var request = URLRequest(url: registerUrl)
    
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    let body: [String: AnyHashable] = [
        "auth_type": "PROPROMO",
        "name": "Stevan Vlajic",
        "email": "stevanvlajadic@gmail.com",
        "password": "Test-Hallo-Welt"
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else{
            return
        }
        
        do{
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("Success: \(response)")
        }catch{
            print(error)
        }
    }
    task.resume()
}
