//
//  MappableProtocol.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/30/21.
//

//MARK: - MappableProtocol

protocol MappableProtocol {
    
    associatedtype PersistenceType: Storable
    
    //MARK: - Method
    
    func mapToPersistenceObject() -> PersistenceType
    static func mapFromPersistenceObject(_ object: PersistenceType) -> Self
    
}
