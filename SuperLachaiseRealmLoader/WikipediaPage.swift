//
//  WikipediaPage.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift

final class WikipediaPage: Object {
    
    dynamic var language = ""
    dynamic var title = ""
    
    dynamic var extract = ""
    
    let localizedWikidataEntries = LinkingObjects(fromType: LocalizedWikidataEntry.self, property: "wikipediaPage")
    
}
