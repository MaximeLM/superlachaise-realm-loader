//
//  OpenStreetMapElement+RealmLoader.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension OpenStreetMapElement {
    
    convenience init(json: JSON, realm: Realm) throws {
        self.init()
        
        try json["element_type"].assertType(type: .string)
        try json["numeric_id"].assertType(type: .number)
        try json["latitude"].assertType(type: .number)
        try json["longitude"].assertType(type: .number)
        try json["wikidata_entry"].assertType(type: .string)
        
        self.elementType = json["element_type"].stringValue
        self.numericId = json["numeric_id"].int64Value
        self.id = "\(elementType)|\(numericId)"
        self.latitude = json["latitude"].doubleValue
        self.longitude = json["longitude"].doubleValue
        self.wikidataEntry = try realm.objectOrThrow(ofType: WikidataEntry.self, forPrimaryKey: json["wikidata_entry"].stringValue)
        
        realm.add(self)
    }
    
}
