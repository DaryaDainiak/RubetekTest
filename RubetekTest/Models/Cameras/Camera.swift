//
//  Camera.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import Foundation

struct Camera: Decodable {
    let id: Int
    let name: String
    let snapshot: String
    let room: String?
    let favorites: Bool
    let rec: Bool
}
