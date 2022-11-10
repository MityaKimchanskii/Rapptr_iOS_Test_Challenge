//
//  LoginClient.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import Foundation

class LoginClient {
    static let shared = LoginClient()
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (String, String) -> Void, error errorHandler: @escaping (NetworkError?) -> Void) {
        let startTimer = CFAbsoluteTimeGetCurrent()
        
        let baseURL = String(format: "https://dev.rapptrlabs.com/Tests/scripts/login.php")
        guard let serviceUrl = URL(string: baseURL) else { return errorHandler(NetworkError.invalidURL) }
        
        let parameters: [String: Any] = [
            "email" : email,
            "password": password
        ]
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        request.httpBody = httpBody
        request.timeoutInterval = 20
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                errorHandler(NetworkError.thrownError(error))
            }
            
            if let response = response {
                print("HTTP response: \(response)")
            }
            
            guard let data = data  else { return errorHandler(NetworkError.noData) }
            
            do {
                let jsonData = try JSONDecoder().decode(LoginResponse.self, from: data)
                let message = jsonData.message
                print("JSON Message: \(message)")
                
                let timeDifference = CFAbsoluteTimeGetCurrent() - startTimer
                let timeDifferenceToMilliseconds = timeDifference * 1000
                let formatedDifference = String(format: "%.0f", timeDifferenceToMilliseconds)
                print("The API call took: \(formatedDifference) ms")
                
                completion(formatedDifference, message)
            } catch {
                errorHandler(NetworkError.unableToDecode)
            }
        }.resume()
    }
}
