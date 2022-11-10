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
    var apiCallTime: String?
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
        let startTimer = CFAbsoluteTimeGetCurrent()
        
        let baseURL = String(format: "https://dev.rapptrlabs.com/Tests/scripts/login.php")
        guard let serviceUrl = URL(string: baseURL) else { return completion(.failure(.invalidURL)) }
        
        let parameters: [String: Any] = [
            "email" : email,
            "password": password
        ]

        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return completion(.failure(.errorHttpBody)) }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response {
                print("HTTP response: \(response)")
            }
            
            guard let data = data  else { return completion(.failure(.noData)) }
            
            do {
                let jsonData = try JSONDecoder().decode(LoginResponse.self, from: data)
                print("JSON Message: \(jsonData.message)")
                
                let timeDifference = CFAbsoluteTimeGetCurrent() - startTimer
                let timeDifferenceToMilliseconds = timeDifference * 1000
                self.apiCallTime = String(format: "%.0f", timeDifferenceToMilliseconds)
                print("The API call took: ", self.apiCallTime ?? "0", " ms")
                
                completion(.success(jsonData))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
