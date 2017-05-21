//
//  WikidataDate.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift

class WikidataDate: Object {
    
    dynamic var rawPrecision = ""
    dynamic var year = 0
    let month = RealmOptional<Int>()
    let day = RealmOptional<Int>()
    
    let birthOf = LinkingObjects(fromType: WikidataEntry.self, property: "dateOfBirth")
    let deathOf = LinkingObjects(fromType: WikidataEntry.self, property: "dateOfDeath")
    
}
