//
//  Rooms.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import Foundation
import Realm
import RealmSwift


//@objcMembers final class AllDataRealm: Object {
//    dynamic var success: Bool = Bool()
//    dynamic var data: DataModelRealm? = nil
//
//    dynamic var id = ObjectId.generate()
//
//    enum CodingKeys: String, CodingKey {
//        case data
//        case success
//    }
//
//    override public init() {}
//
////    required init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
//////        self.data = try DataModel(from: decoder)
////        self.data = try? values.decode(DataModelRealm.self, forKey: .data)
////        self.success = try values.decode(Bool.self, forKey: .success)
////
////        super.init()
////    }
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//}

@objcMembers final class DataModelRealm: Object {
    dynamic var room = RealmSwift.List<String>()
    dynamic var cameras = RealmSwift.List<CameraRealm>()
    dynamic var id = ObjectId.generate()
    
    internal init(rooms: [String], cameras: [Camera]) {
        self.room.append(objectsIn: rooms)
        self.cameras.append(objectsIn: cameras.map { CameraRealm(from: $0)})
    }
    
    enum CodingKeys: String, CodingKey {
        case cameras
        case room
    }
    
    override public init() {}
    
    //    required init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        let cameraList = try values.decode([CameraRealm].self, forKey: .cameras)
    //        let roomList = try values.decode([String].self, forKey: .room)
    //
    //        let cameraListUnwraped = cameraList
    //        cameras.append(objectsIn: cameraListUnwraped)
    //
    //        let roomListUnwraped = roomList
    //        room.append(objectsIn: roomListUnwraped)
    //        super.init()
    //    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

@objcMembers final class CameraRealm: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var snapshot: String = ""
    dynamic var room: String? = nil
    dynamic var favorites: Bool = Bool()
    dynamic var rec: Bool = Bool()
    
    init(id: Int, name: String, snapshot: String, room: String?, favorites: Bool, rec: Bool) {
        self.id = id
        self.name = name
        self.snapshot = snapshot
        self.room = room
        self.favorites = favorites
        self.rec = rec
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case snapshot
        case room
        case favorites
        case rec
    }
    
    override public init() {}
    
    //    required init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        self.id = try values.decode(Int.self, forKey: .id)
    //        self.name = try values.decode(String.self, forKey: .name)
    //        self.snapshot = try values.decode(String.self, forKey: .snapshot)
    //        self.room = try? values.decode(String.self, forKey: .room)
    //        self.favorites = try values.decode(Bool.self, forKey: .favorites)
    //        self.rec = try values.decode(Bool.self, forKey: .rec)
    //
    //        super.init()
    //    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension DataModelRealm {
    convenience init(from model: DataModel) {
        self.init(
            rooms: model.room,
            cameras: model.cameras
        )
    }
}

extension CameraRealm {
    convenience init(from model: Camera) {
        
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

