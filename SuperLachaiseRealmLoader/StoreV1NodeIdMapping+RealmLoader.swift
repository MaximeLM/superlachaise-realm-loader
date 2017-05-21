//
//  StoreV1NodeIdMapping+RealmLoader.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 22/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension StoreV1NodeIdMapping {
    
    convenience init(json: JSON, realm: Realm) throws {
        self.init()
        
        try json["id"].assertType(type: .number)
        try json["wikidata_entry"].assertType(type: .string)
        
        self.id = json["id"].int64Value
        self.wikidataEntry = try realm.objectOrThrow(ofType: WikidataEntry.self, forPrimaryKey: json["wikidata_entry"].stringValue)
        
        realm.add(self)
    }
    
}
