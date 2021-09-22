//
//  Doors.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/22/21.
//

import Foundation

struct FullData: Decodable {
    let success: Bool
    let data: [Door]
}

struct Door: Decodable {
    let id: Int
    let name: String
    let snapshot: String?
    let room: String?
    let favorites: Bool
}
