//
//  Doors+MappableProtocol.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/30/21.
//

import Foundation

extension Door: MappableProtocol {
    
    func mapToPersistenceObject() -> DoorRealm {
        
        return DoorRealm(from: self)
    }
    
    static func mapFromPersistenceObject(_ object: DoorRealm) -> Door {
        
        return Door(from: object)
    }
}
