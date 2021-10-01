//
//  DoorsRepositoryProtocol.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/30/21.
//

//MARK: - DoorsRepositoryProtocol

protocol DoorsRepositoryProtocol {
    
    func getData(completion: ([Door]) -> Void)
    func saveData(doors: [Door])
}
