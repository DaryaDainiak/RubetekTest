
//
//  Network.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/24/21.
//

import Foundation

protocol NetworkServiceProtocol {
    static func request<T: Codable>(api: Api, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    static func request<T: Codable>(api: Api, completion: @escaping (Result<T, Error>) -> Void) {
        let components = api.getComponents()
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            guard response != nil , let data = data else { return }
            
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
}

