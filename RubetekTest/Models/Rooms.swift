//
//  Rooms.swift
//  RubetekTest
//
//  Created by Aliaksandr Dainiak on 9/21/21.
//

import Foundation


struct AllData: Decodable {
    let success: Bool
    let data: DataModel
}

struct DataModel: Decodable {
    let room: [String]
    let cameras: [Camera]
}
