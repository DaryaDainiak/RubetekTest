//
//  CameraRepositoryProtocol.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/30/21.
//

//MARK: - CameraRepositoryProtocol

protocol CameraRepositoryProtocol {
    
    func getDataModel(completion: (DataModel) -> Void)
    func saveDataModel(dataModel: DataModel)
}
