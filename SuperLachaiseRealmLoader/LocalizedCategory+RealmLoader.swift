//
//  LocalizedCategory+RealmLoader.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension LocalizedCategory {
    
    convenience init(json: JSON, category: Category, realm: Realm) throws {
        self.init()
        
        try json["language"].assertType(type: .string)
        try json["label"].assertType(type: .string)
        
        self.language = json["language"].stringValue
        self.category = category
        self.label = json["label"].stringValue
        
        realm.add(self)
    }
    
}
