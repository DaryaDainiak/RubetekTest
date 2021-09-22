//
//  Camera.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import Foundation

struct Camera: Decodable {
    let name: String
    let snapshot: String
    let room: String?
    let id: Int
    let favorites: Bool
    let rec: Bool
}
