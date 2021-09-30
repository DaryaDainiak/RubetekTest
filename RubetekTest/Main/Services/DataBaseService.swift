//
//  DataBaseService.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/30/21.
//

import Foundation

//MARK: - DataBaseService Protocol

protocol DataBaseService {
    func save(object: Storable)
    func get<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: (([T]) -> ()))
    func delete(object: Storable)
    func deleteAll<T: Storable>(_ model: T.Type)
}

