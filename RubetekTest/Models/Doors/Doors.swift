//
//  Doors.swift
//  RubetekTest
//
//  Created by Aliaksandr Dainiak on 9/22/21.
//

import Foundation

struct FullData: Decodable {
    let success: Bool
    let data: [Door]
}

struct Door: Decodable {
    let name: String
    let snapshot: String?
    let room: String?
    let id: Int
    let favorites: Bool
}
