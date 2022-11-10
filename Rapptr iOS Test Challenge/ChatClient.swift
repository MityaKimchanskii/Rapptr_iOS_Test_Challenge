//
//  ChatClient.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import Foundation

class ChatClient {
    
    static let shared = ChatClient()
    private init() {}
    
    let baseURL = URL(string: "https://dev.rapptrlabs.com/Tests/scripts/chat_log.php")
    
    func fetchChatData(completion: @escaping (Result<[Message], NetworkError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Response: \(String(describing: response))")
                return
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let jsonData = try JSONDecoder().decode(JSONData.self, from: data)
                let messageArray = jsonData.data
                return completion(.success(messageArray))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
