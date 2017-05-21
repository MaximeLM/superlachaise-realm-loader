//
//  WikipediaPage+JSON.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension WikipediaPage {
    
    convenience init(json: JSON, realm: Realm) throws {
        self.init()
        
        try json["language"].assertType(type: .string)
        try json["title"].assertType(type: .string)
        try json["extract"].assertType(type: .string)
        
        self.language = json["language"].stringValue
        self.title = json["title"].stringValue
        self.extract = json["extract"].stringValue
        
        realm.add(self)
    }
    
}
