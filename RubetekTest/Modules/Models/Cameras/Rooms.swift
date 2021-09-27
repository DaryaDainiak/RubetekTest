//
//  Rooms.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/27/21.
//

import Foundation

struct AllData: Codable {
    let success: Bool
    let data: DataModel
}

struct DataModel: Codable {
    let room: [String]
    let cameras: [Camera]
}

struct Camera: Codable {
    
    let id: Int
    let name: String
    let snapshot: String
    let room: String?
    let favorites: Bool
    let rec: Bool
}

extension Camera {
    init(from model: CameraRealm) {
        self.init(
            id: model.id,
            name: model.name,
            snapshot: model.snapshot,
            room: model.room,
            favorites: model.favorites,
            rec: model.rec
        )
    }
}


