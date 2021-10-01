//
//  DoorsRealm.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/27/21.
//

import Foundation
import Realm
import RealmSwift

@objcMembers final class FullDataRealm: Object {
    dynamic var success: Bool = Bool()
    dynamic var data = RealmSwift.List<DoorRealm>()
    
    internal init(success: Bool, data: [Door]) {
        self.success = success
        self.data.append(objectsIn: data.map {
            DoorRealm(from: $0)
        })
    }
    
    enum CodingKeys: String, CodingKey {
        case success
        case data
    }
    
    override public init() {}
}

@objcMembers final class DoorRealm: Object {
    
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var snapshot: String? = nil
    dynamic var room: String? = nil
    dynamic var favorites: Bool = Bool()
    
    init(id: Int, name: String, snapshot: String?, room: String?, favorites: Bool) {
        self.id = id
        self.name = name
        self.snapshot = snapshot
        self.room = room
        self.favorites = favorites
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case snapshot
        case room
        case favorites
    }
    
    override public init() {}
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension DoorRealm {
    convenience init(from model: Door) {
        
        self.init(
            id: model.id,
            name: model.name,
            snapshot: model.snapshot,
            room: model.room,
            favorites: model.favorites
        )
    }
}
