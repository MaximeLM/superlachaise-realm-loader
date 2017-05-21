//
//  OpenStreetMapElement.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift

class OpenStreetMapElement: Object {
    
    dynamic var elementType = ""
    dynamic var numericID: Int64 = 0
    
    dynamic var latitude = 0.0
    dynamic var longitude = 0.0
    
    dynamic var wikidataEntry: WikidataEntry?
    
}
