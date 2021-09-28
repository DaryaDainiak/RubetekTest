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
    
    static func getData(isRefresh: Bool = false, completion: @escaping (Result<AllData, Error>) -> Void) {

          if !isRefresh {
              if let dataModelRealm = try? RealmService.get(DataModelRealm.self), !dataModelRealm.isEmpty {
                  let dataModel = Array(dataModelRealm)
                  if let cameras = dataModel.first?.cameras,
                     let rooms = dataModel.first?.room {
                      let dataModel = DataModel(room: Array(rooms), cameras: Array(cameras).map {Camera(from: $0) } )
                      let allData = AllData(success: true, data: dataModel)
                      
                    completion(.success(allData))
                  }
              }
          }
          NetworkService.request(api: Api.getCameras) { (result: Result<AllData, Error>) in
              switch result {
              case .success(let allData):
                completion(.success(allData))
                  DispatchQueue.main.async {
                      let dataModelRealm = DataModelRealm(rooms: allData.data.room, cameras: allData.data.cameras)
                      
                      RealmService.save(items: [dataModelRealm])
                  }
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

