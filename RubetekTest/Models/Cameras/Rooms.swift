//
//  Rooms.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import Foundation
import Realm
import RealmSwift


@objcMembers final class AllData: Object, Codable {
    dynamic var success: Bool = Bool()
    dynamic var data: DataModel? = DataModel()
    
    dynamic var id = ObjectId.generate()
    
    enum CodingKeys: String, CodingKey {
        case data
        case success
    }
        
//    override public init() {}
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.data = try DataModel(from: decoder)
        self.data = try? values.decode(DataModel.self, forKey: .data)
        self.success = try values.decode(Bool.self, forKey: .success)
        
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
//    required override init()
//    {
//        super.init()
//    }
//
//       required init(value: Any, schema: RLMSchema)
//       {
//           super.init(value: value)
//       }
//
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        super.init(realm: realm, schema: schema)
//    }
}

@objcMembers final class DataModel: Object, Codable {
    dynamic var room = RealmSwift.List<String>()
    dynamic var cameras = RealmSwift.List<Camera>()
    dynamic var id = ObjectId.generate()
    
    enum CodingKeys: String, CodingKey {
        case cameras
        case room
    }
    
    override public init() {}
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let cameraList = try values.decode([Camera].self, forKey: .cameras)
        let roomList = try values.decode([String].self, forKey: .room)
        
//        if let cameraListUnwraped = cameraList {
//            cameras.append(objectsIn: cameraListUnwraped)
//        }
//        if let roomListUnwraped = roomList  {
//            room.append(objectsIn: roomListUnwraped)
        //        }
        let cameraListUnwraped = cameraList
        cameras.append(objectsIn: cameraListUnwraped)
        
        let roomListUnwraped = roomList
        room.append(objectsIn: roomListUnwraped)
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

}

@objcMembers final class Camera: Object, Codable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var snapshot: String = ""
    dynamic var room: String? = nil
    dynamic var favorites: Bool = Bool()
    dynamic var rec: Bool = Bool()
    
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
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.snapshot = try values.decode(String.self, forKey: .snapshot)
        self.room = try? values.decode(String.self, forKey: .room)
        self.favorites = try values.decode(Bool.self, forKey: .favorites)
        self.rec = try values.decode(Bool.self, forKey: .rec)
        
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

