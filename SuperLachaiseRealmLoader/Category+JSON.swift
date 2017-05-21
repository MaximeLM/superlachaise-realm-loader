//
//  Category+JSON.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension Category {
    
    convenience init(json: JSON, realm: Realm) throws {
        self.init()
        
        try json["id"].assertType(type: .string)
        try json["localizations"].assertType(type: .dictionary)
        
        self.id = json["id"].stringValue
        
        realm.add(self)
        
        for (_, localizationJSON) in json["localizations"].dictionaryValue {
            _ = try LocalizedCategory(json: localizationJSON, category: self, realm: realm)
        }
    }
    
}
