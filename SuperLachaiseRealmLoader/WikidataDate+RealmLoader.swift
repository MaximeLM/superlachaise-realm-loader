//
//  WikidataDate+RealmLoader.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension WikidataDate {
    
    convenience init(json: JSON, wikidataEntry: WikidataEntry, kind: String, realm: Realm) throws {
        self.init()
        
        try json["precision"].assertType(type: .string)
        
        self.id = "\(kind)|\(wikidataEntry.id)"
        self.rawPrecision = json["precision"].stringValue
        self.year.value = json["year"].int
        self.month.value = json["month"].int
        self.day.value = json["day"].int
        
        guard let precision = self.precision else {
            throw WikidataDateJSONError.invalidPrecision(rawPrecision: self.rawPrecision)
        }
        switch precision {
        case .day:
            try json["day"].assertType(type: .number)
            fallthrough
        case .month:
            try json["month"].assertType(type: .number)
            fallthrough
        case .year:
            try json["year"].assertType(type: .number)
        }
        
        realm.add(self)
    }
    
}

enum WikidataDateJSONError: Error {
    case invalidPrecision(rawPrecision: String)
}
