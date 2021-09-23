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
            if let dataModelRealm = try? RealmService.get(DataModel.self), !dataModelRealm.isEmpty {
                let dataModel = Array(dataModelRealm)
                if let cameras = dataModel.first?.cameras,
                   let rooms = dataModel.first?.room {
                    completion(.success((Array(rooms), Array(cameras))))
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
                
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let dictionary = json {
                    if let dataModelDict = dictionary["data"] as? [String: Any] {
                        var rooms: [String] = []
                        var cameras: [Camera] = []
                        
                        if let camerasArray = dataModelDict["cameras"] as? [[String: Any]] {
                            camerasArray.forEach {
                                let camera = Camera()
                                camera.id = $0["id"] as? Int ?? 0
                                camera.name = $0["name"] as? String ?? ""
                                camera.snapshot = $0["snapshot"] as? String ?? ""
                                camera.room = $0["room"] as? String ?? ""
                                camera.favorites = $0["favorites"] as? Bool ?? false
                                camera.rec = $0["rec"] as? Bool ?? false
                                cameras.append(camera)
                            }
                        }
                        
                        if let roomsList = dataModelDict["room"] as? [String] {
                            rooms = roomsList
                        }
                        
                        completion(.success((rooms, cameras)))
                        
                        DispatchQueue.main.async {
                            let dataModel = DataModel()
                            dataModel.cameras.append(objectsIn: cameras)
                            dataModel.room.append(objectsIn: rooms)
                            
                            RealmService.save(items: [dataModel])
                        }
                    }
                }
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
