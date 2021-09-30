//
//  Item.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/29/21.
//

import Foundation
import RealmSwift

protocol Item: Object {
    dynamic var id: AnyHashable { get set }
    static func primaryKey() -> String
}
