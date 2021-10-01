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
    
    static func getData(
        repository: DoorsRepositoryProtocol,
        isRefresh: Bool = false,
        completion: @escaping (Result<[Door], Error>) -> Void
    ) {
        var goNetwork = true
        
        if !isRefresh {
            repository.getData() { (doors: [Door]) in completion(.success(doors))
                goNetwork = doors.isEmpty
            }
        }
        guard goNetwork else { return }
        
        NetworkService.request(api: Api.getDoors) { (result: Result<FullData, Error>) in
            switch result {
            case .success(let fullData):
                completion(.success(fullData.data))
                repository.saveData(doors: fullData.data)
                
            case .failure(let error):
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

