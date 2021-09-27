//
//  DoorsRealm.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/27/21.
//

//import Foundation
//import Realm
//import RealmSwift
//
//@objcMembers final class FullDataRealm: Object {
//    dynamic var success: Bool = Bool()
//    dynamic var data = RealmSwift.List<DoorRealm>()
//    
//    internal init(success: Bool, data: [Door]) {
//        self.data.append(objectsIn: rooms)
//        self.cameras.append(objectsIn: cameras.map { CameraRealm(from: $0)})
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case success
//        case data
//    }
//    
//    override public init() {}
//
//}
//
//@objcMembers final class DoorRealm: Object {
//    dynamic var id: Int = 0
//    dynamic var name: String = ""
//    dynamic var snapshot: String? = nil
//    dynamic var room: String? = nil
//    dynamic var favorites: Bool = Bool()
//}
