//
//  Rooms.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import Foundation
import RealmSwift


@objcMembers final class AllData: Object, Codable {
    dynamic var success: Bool = Bool()
    dynamic var data = DataModel()
    
    enum CodingKeys: String, CodingKey {
        case data
        case success = "success"
    }
    
    override public init() {}
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try DataModel(from: decoder)
        self.success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        
        super.init()
    }
}

@objcMembers final class DataModel: Object, Codable {
    dynamic var room = List<String>()
    dynamic var cameras = List<Camera>()
    
    enum CodingKeys: String, CodingKey {
        case cameras = "cameras"
        case room = "room"
    }
    
    override public init() {}
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let cameraList = try values.decodeIfPresent([Camera].self, forKey: .cameras)
        let roomList = try values.decodeIfPresent([String].self, forKey: .room)
        
        if let cameraListUnwraped = cameraList {
            cameras.append(objectsIn: cameraListUnwraped)
        }
        if let roomListUnwraped = roomList  {
            room.append(objectsIn: roomListUnwraped)
        }
        
        super.init()
    }
}

@objcMembers final class Camera: Object, Codable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var snapshot: String? = nil
    dynamic var room: String = ""
    dynamic var favorites: Bool = false
    dynamic var rec: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case snapshot
        case room
        case favorites
        case rec
    }
    
    override public init() {}
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.name = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.snapshot = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.room = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.favorites = try values.decodeIfPresent(Bool.self, forKey: .id) ?? false
        self.rec = try values.decodeIfPresent(Bool.self, forKey: .id) ?? false
        
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

