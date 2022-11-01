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
    
    func login(email: String, password: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let start = CFAbsoluteTimeGetCurrent()
        
        let baseUrl = String(format: "https://dev.rapptrlabs.com/Tests/scripts/login.php")
        guard let serviceUrl = URL(string: baseUrl) else { return }
        
        let parameters: [String: Any] = [
            "email" : email,
            "password": password
        ]
        
        var requestURL = URLRequest(url: serviceUrl)
        requestURL.httpMethod = "POST"
        requestURL.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        requestURL.httpBody = httpBody
        requestURL.timeoutInterval = 20
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Response: \(String(describing: response))")
                completion(.failure(.invalidParameters))
                return
            }
            
            guard let data = data else { return completion(.failure(.noData)) }

            do {
                let jsonData = try JSONDecoder().decode(String.self, from: data)
                let message = jsonData
                print("Json message:", message)

                let diff = CFAbsoluteTimeGetCurrent() - start
                let diffToMilli = diff * 1000
                let diffFormated = String(format: "%.0f", diffToMilli)
                
                print("Request took \(diffFormated) ms")

                completion(.success("\(diffFormated) ===== \(message)"))
            } catch {
                print("Request tooktook ms")

                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
