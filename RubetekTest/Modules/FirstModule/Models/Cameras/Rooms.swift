//
//  Rooms.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/27/21.
//

import Foundation

struct AllData: Codable {
    let success: Bool
    let data: DataModel
    
    static func getData(
        repository: CameraRepositoryProtocol,
        isRefresh: Bool = false,
        completion: @escaping (Result<DataModel, Error>) -> Void
    ) {
        var goNetwork = true
        
        if !isRefresh {
            repository.getDataModel() { (dataModel: DataModel) in
                completion(.success(dataModel))
                goNetwork = false
            }
        }
        
        guard goNetwork else { return }
        
        NetworkService.request(api: Api.getCameras) { (result: Result<AllData, Error>) in
            switch result {
            case .success(let allData):
                completion(.success(allData.data))
                repository.saveDataModel(dataModel: DataModel(room: allData.data.room, cameras: allData.data.cameras))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct DataModel: Codable {
    let room: [String]
    let cameras: [Camera]
}

extension DataModel: MappableProtocol {
    
    func mapToPersistenceObject() -> DataModelRealm {
        
        return DataModelRealm(rooms: room, cameras: cameras)
    }
    
    static func mapFromPersistenceObject(_ object: DataModelRealm) -> DataModel {
        let cameras = object.cameras
        let rooms = object.room
        
        return DataModel(room: Array(rooms), cameras: cameras.compactMap {Camera(from: $0) } )
    }
}

struct Camera: Codable {
    
    let id: Int
    let name: String
    let snapshot: String
    let room: String?
    let favorites: Bool
    let rec: Bool
}

extension Camera {
    init(from model: CameraRealm) {
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

