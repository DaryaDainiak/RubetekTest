//
//  Doors.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/22/21.
//

import Foundation

struct FullData: Codable {
    let success: Bool
    let data: [Door]
    
    static func getData(isRefresh: Bool = false, completion: @escaping (Result<[Door], Error>) -> Void) {

        if !isRefresh {
            if let doorRealm = try? RealmService.get(DoorRealm.self), !doorRealm.isEmpty {
                let doorRealmArray: [DoorRealm] = Array(doorRealm)
                let doors: [Door] = doorRealmArray.map { Door(from: $0)}
                
                 completion(.success(doors))
            }
        }
        NetworkService.request(api: Api.getDoors) { (result: Result<FullData, Error>) in
            switch result {
            case .success(let fullData):
                completion(.success(fullData.data))
                DispatchQueue.main.async {
                    let doorsRealm = fullData.data.map { DoorRealm(from: $0)}
                    
                    RealmService.save(items: doorsRealm)
                }            case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

struct Door: Codable {
    let id: Int
    let name: String
    let snapshot: String?
    let room: String?
    let favorites: Bool
}

extension Door {
    init(from model: DoorRealm) {
        self.init(
            id: model.id,
            name: model.name,
            snapshot: model.snapshot,
            room: model.room,
            favorites: model.favorites
        )
    }
}

