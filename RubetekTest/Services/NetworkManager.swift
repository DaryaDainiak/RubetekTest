//
//  NetworkManager.swift
//  RubetekTest
//
//  Created by Aliaksandr Dainiak on 9/21/21.
//

import Foundation


protocol NetworkManagerProtocol {
    func getRooms(completion: @escaping (Result<DataModel, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func getRooms(completion: @escaping (Result<DataModel, Error>) -> Void) {
        let urlString =
            "https://cars.cprogroup.ru/api/rubetek/cameras/"
        let components = URLComponents(string: urlString)
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in

            guard let data = data else { return }
            do {
                let allData = try JSONDecoder().decode(AllData.self, from: data)
                
                completion(.success(allData.data))
                
            } catch(let error) {
                completion(.failure(error))
                print("Error serialization json \(error)", error.localizedDescription)
            }
        }.resume()
    }
  
}
