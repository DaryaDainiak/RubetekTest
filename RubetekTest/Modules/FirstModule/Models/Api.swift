//
//  Api.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/27/21.
//

import Foundation

enum Api {
    case getCameras
    case getDoors
    
    var scheme: String {
        switch self {
        case .getCameras, .getDoors:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getCameras, .getDoors:
            return "cars.cprogroup.ru"
        }
    }
    
    var path: String {
        switch self {
        case .getCameras:
            return "/api/rubetek/cameras/"
        case .getDoors:
            return "/api/rubetek/doors/"
        }
    }
    
    var method: String {
        switch self {
        case .getCameras, .getDoors:
            return "GET"
        }
    }
    func getComponents (api: Api) -> URLComponents {
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.host
        components.path = api.path
        
        return components
    }
}