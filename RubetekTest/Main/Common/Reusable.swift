//
//  Reusable.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/27/21.
//

import Foundation

public protocol Reusable {
    static var reuseID: String { get }
}

public extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

