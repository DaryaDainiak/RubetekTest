//
//  DoorsRepository.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/30/21.
//

import Foundation

final class DoorsRepository: DoorsRepositoryProtocol {
    
    //MARK: - Stored Properties
    
    var dbManager: DataBaseService
    
    //MARK: - Init
    
    required init(dbManager: DataBaseService) {
        self.dbManager = dbManager
    }
    
    func getData(completion: ([Door]) -> Void) {
        self.dbManager.get(DoorRealm.self, predicate: nil) {
            
            let doors = $0.compactMap { Door.mapFromPersistenceObject($0) }

            completion(doors)
        }
    }
    
    func saveData(doors: [Door]) {
        dbManager.save(objects: doors.compactMap { $0.mapToPersistenceObject() })
    }
}
