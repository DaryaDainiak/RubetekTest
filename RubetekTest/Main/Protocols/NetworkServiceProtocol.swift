//
//  NetworkServiceProtocol.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/30/21.
//

//MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol {
    static func request<T: Codable>(api: Api, completion: @escaping (Result<T, Error>) -> Void)
}

