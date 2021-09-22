
//  RealmService.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 10/21/21.
//

import RealmSwift

///
final class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    static func save<T: Object>(
        items: [T],
        config: Realm.Configuration = Realm.Configuration.defaultConfiguration,
        update: Bool = true
    ) {
        guard let fileURL = config.fileURL else { return }
        print("\(fileURL)")

        do {
            let realm = try Realm(configuration: config)

            try realm.write {
                realm.add(items, update: .all)
            }

        } catch {
            print(error)
        }
    }

    static func get<T: Object>(
        _ type: T.Type,
        config: Realm.Configuration = Realm.Configuration.defaultConfiguration
    )
        throws -> Results<T>
    {
        let realm = try Realm(configuration: config)
        let results = realm.objects(type)
        return results
    }

    static func delete<T: Object>(
        _ items: [T],
        config: Realm.Configuration = Realm.Configuration.defaultConfiguration
    ) {
        let realm = try? Realm(configuration: config)
        try? realm?.write {
            realm?.delete(items)
        }
    }

    static func deleteAll(
        config: Realm.Configuration = Realm.Configuration.defaultConfiguration
    ) {
        let realm = try? Realm(configuration: config)
        try? realm?.write {
            realm?.deleteAll()
        }
    }
}
