//
//  Realm.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift

extension Realm {
    
    func objectOrThrow<T: Object, K>(ofType type: T.Type, forPrimaryKey key: K) throws -> T {
        guard let object = object(ofType: type, forPrimaryKey: key) else {
            assertionFailure()
            throw RealmError.objectNotFound
        }
        return object
    }
    
    func objectOrThrow<T: Object>(ofType type: T.Type, predicate: NSPredicate) throws -> T {
        let objects = self.objects(type).filter(predicate)
        guard let object = objects.first, objects.count == 1 else {
            assertionFailure()
            throw RealmError.objectNotFound
        }
        return object
    }
    
}

enum RealmError: Error {
    case objectNotFound
}
