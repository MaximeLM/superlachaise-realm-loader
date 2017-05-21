//
//  LocalizedCategory.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift

final class LocalizedCategory: Object {
    
    dynamic var language = ""
    dynamic var category: Category?
    
    dynamic var label = ""
    
    override class func indexedProperties() -> [String] {
        return ["language"]
    }
    
}
