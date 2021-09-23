//
//  NetworkManager.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import Foundation
import RealmSwift


protocol NetworkManagerProtocol {
    func getRooms(isRefresh: Bool, completion: @escaping (Result<DataModel, Error>) -> Void)
    func getDoors(isRefresh: Bool, completion: @escaping (Result<[Door], Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func getRooms(isRefresh: Bool, completion: @escaping (Result<DataModel, Error>) -> Void) {
        
//        if !isRefresh {
//            if let dataInRealm = try? RealmService.get(DataModel.self), !dataInRealm.isEmpty {
//                let data = Array(dataInRealm)
//                completion(.success(data))
//            }
//
//            return
//        }
        
        let urlString =
            "https://cars.cprogroup.ru/api/rubetek/cameras/"
        let components = URLComponents(string: urlString)
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in

            guard let data = data else { return }
            do {
                let allData = try JSONDecoder().decode(AllData.self, from: data)
                
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//
//                if let dictionary = json as? [String: Any] {
//                    if let dataModelDict = dictionary["data"] as? [String: Any] {
//                        let rooms = dataModelDict["rooms"]
//                        let cameras = dataModelDict["cameras"]
////                        completion(.success(dataModel))
//                    }
//                }
                
                completion(.success(allData.data ?? DataModel()))
                
            } catch(let error) {
                completion(.failure(error))
                print("Error serialization json \(error)", error.localizedDescription)
            }
        }.resume()
    }
  
    func getDoors(isRefresh: Bool, completion: @escaping (Result<[Door], Error>) -> Void) {
        let urlString =
            "https://cars.cprogroup.ru/api/rubetek/doors/"
        let components = URLComponents(string: urlString)
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in

            guard let data = data else { return }
            do {
                let fullData = try JSONDecoder().decode(FullData.self, from: data)
                
                completion(.success(fullData.data))
                
            } catch(let error) {
                completion(.failure(error))
                print("Error serialization json \(error)", error.localizedDescription)
            }
        }.resume()
    }
}
