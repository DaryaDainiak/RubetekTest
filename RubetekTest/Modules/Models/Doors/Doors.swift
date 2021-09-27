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
    
    static func getData(isRefresh: Bool = false) -> FullData {
        var fullData: FullData
        
        if !isRefresh {
            if let doorRealm = try? RealmService.get(DoorRealm.self), !doorRealm.isEmpty {
                let doorList = Array(doorRealm) {
                    let doorArray = Array(doorList).map {
                        Door(from: $0)
                    }
                    
                    fullData = FullData(success: true, data: doorArray)
                    
                    return с
                }
            }
        }
        NetworkService.request(api: Api.getDoors) { (result: Result<FullData, Error>) in
            switch result {
            case .success(let data):
                fullData = data
                DispatchQueue.main.async {
                    let doorsRealm = DoorRealm()

                    RealmService.save(items: [dataModelRealm])
                }
            case .failure(_):
                fullData = nil
            }
        }
        return fullData
    }
}

struct Door: Codable {
    let id: Int
    let name: String
    let snapshot: String?
    let room: String?
    let favorites: Bool
}

