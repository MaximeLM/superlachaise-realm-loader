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
            throw RealmError.objectNotFound(type: type, pk: key)
        }
        return object
    }
    
}

enum RealmError: Error {
    case objectNotFound(type: Object.Type, pk: Any)
}
