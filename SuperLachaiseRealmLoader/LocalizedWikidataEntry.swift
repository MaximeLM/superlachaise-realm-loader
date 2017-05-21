//
//  LocalizedWikidataEntry.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift

class LocalizedWikidataEntry: Object {
    
    dynamic var language = ""
    dynamic var wikidataEntry: WikidataEntry?
    
    dynamic var label = ""
    dynamic var defaultSort = ""
    dynamic var summary: String?
    
    dynamic var wikipediaPage: WikipediaPage?
    
    override class func indexedProperties() -> [String] {
        return ["language"]
    }
    
}
