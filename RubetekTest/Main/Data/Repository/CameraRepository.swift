//
//  CameraRepository.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/30/21.
//

import Foundation

final class CameraRepository: CameraRepositoryProtocol {
    
    //MARK: - Stored Properties
    
    var dbManager: DataBaseService
    
    //MARK: - Init
    
    required init(dbManager: DataBaseService) {
        self.dbManager = dbManager
    }
    
    func getDataModel(completion: (DataModel) -> Void) {
        self.dbManager.get(DataModelRealm.self, predicate: nil) {
            guard let dataModelRealm = $0.first else { return }
            
            let dataModel =  DataModel.mapFromPersistenceObject(dataModelRealm)
            
            completion(dataModel)
        }
    }
    
    func saveDataModel(dataModel: DataModel) {
        dbManager.save(object: dataModel.mapToPersistenceObject())
    }
}
