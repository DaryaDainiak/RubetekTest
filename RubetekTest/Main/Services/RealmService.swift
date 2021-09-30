
//  RealmService.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/22/21.
//

import Foundation
import RealmSwift

//MARK: - DataBaseService Implementation

final class RealmService: DataBaseService {
    
    //MARK: - Stored Properties
    
    private let realm: Realm?
    
    init(_ realm: Realm?) {
        self.realm = realm
    }
    
    convenience init() {
        let config = Realm.Configuration.defaultConfiguration
        let realm = try? Realm(configuration: config)
        
        self.init(realm)
    }
    
    func save(object: Storable) {
        guard let realm = realm, let object = object as? Object else { return }
        
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print(error)
        }
    }
    
    func get<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: (([T]) -> ())) {
        guard let realm = realm, let model = model as? Object.Type else { return }
        
        var objects = realm.objects(model)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        completion(objects.compactMap { $0 as? T })
    }
    
    func delete(object: Storable) {
        guard let realm = realm, let object = object as? Object else { return }
        
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAll<T>(_ model: T.Type) {
        guard let realm = realm, let model = model as? Object.Type else { return }
        
        do {
            try realm.write {
                let objects = realm.objects(model)
                for object in objects {
                    realm.delete(object)
                }
            }
        } catch {
            print(error)
        }
    }
}
