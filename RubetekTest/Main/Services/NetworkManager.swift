//
//  NetworkManager.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import Foundation
import RealmSwift


protocol NetworkManagerProtocol {
    func getRooms(isRefresh: Bool, completion: @escaping (Result<([String], [Camera]), Error>) -> Void)
    func getDoors(isRefresh: Bool, completion: @escaping (Result<[Door], Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func getRooms(isRefresh: Bool, completion: @escaping (Result<([String], [Camera]), Error>) -> Void) {
        
        if !isRefresh {
            if let dataModelRealm = try? RealmService.get(DataModelRealm.self), !dataModelRealm.isEmpty {
                let dataModel = Array(dataModelRealm)
                if let cameras = dataModel.first?.cameras,
                   let rooms = dataModel.first?.room {
                    
                    completion(.success((Array(rooms), Array(cameras).map {Camera(from: $0) } )))
                    return
                }
            }
        }
        
        let urlString =
            "https://cars.cprogroup.ru/api/rubetek/cameras/"
        let components = URLComponents(string: urlString)
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data else { return }
            do {
                
                let dataModel = try JSONDecoder().decode(AllData.self, from: data).data
                        
                completion(.success((dataModel.room, dataModel.cameras)))
                        
                        DispatchQueue.main.async {
                            let dataModelRealm = DataModelRealm(rooms: dataModel.room, cameras: dataModel.cameras)

                            RealmService.save(items: [dataModelRealm])
                        }
//                    }
//                }
            }
            catch(let error) {
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
