
//
//  Network.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/24/21.
//

import Foundation

enum Api {
    case getCameras
    case getDoors
    
    var scheme: String {
        switch self {
        case .getCameras, .getDoors:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getCameras, .getDoors:
            return "cars.cprogroup.ru"
        }
    }
    
    var path: String {
        switch self {
        case .getCameras:
            return "/api/rubetek/cameras/"
        case .getDoors:
            return "/api/rubetek/doors/"
        }
    }
    
    var method: String {
        switch self {
        case .getCameras, .getDoors:
            return "GET"
        }
    }
}

class NetworkService {
    class func request<T: Codable>(api: Api, completion: @escaping (Result<[String: [T]], Error>) -> Void) {
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.host
        components.path = api.path
        
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
            
            let responseObject = try! JSONDecoder().decode([String: [T]].self, from: data)
                       DispatchQueue.main.async {
                           completion(.success(responseObject))
                       }
                   }
                   dataTask.resume()
        }
    }

