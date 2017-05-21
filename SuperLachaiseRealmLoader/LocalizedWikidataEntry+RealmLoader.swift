//
//  LocalizedWikidataEntry+RealmLoader.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension LocalizedWikidataEntry {
    
    convenience init(json: JSON, wikidataEntry: WikidataEntry, realm: Realm) throws {
        self.init()
        
        try json["language"].assertType(type: .string)
        try json["label"].assertType(type: .string)
        try json["default_sort"].assertType(type: .string)
        if wikidataEntry.kind == .graveOf {
            try json["description"].assertType(type: .string)
        }
        
        self.language = json["language"].stringValue
        self.wikidataEntry = wikidataEntry
        self.label = json["label"].stringValue
        self.defaultSort = json["default_sort"].stringValue
        self.summary = json["description"].string
        if let title = json["wikipedia_page"].string {
            let predicate = NSPredicate(format: "language == %@ AND title == %@", language, title)
            self.wikipediaPage = try realm.objectOrThrow(ofType: WikipediaPage.self, predicate: predicate)
        }
        
        realm.add(self)
    }
    
}
