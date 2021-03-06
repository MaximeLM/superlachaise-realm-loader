//
//  WikidataEntry+RealmLoader.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension WikidataEntry {
    
    convenience init(json: JSON, realm: Realm) throws {
        self.init()
        
        try json["id"].assertType(type: .string)
        try json["kind"].assertType(type: .string)
        try json["burial_plot_reference"].assertType(type: .string)
        try json["localizations"].assertType(type: .dictionary)
        try json["commons_category"].assertType(type: .string)
        
        guard let jsonKind = JSONKind(rawValue: json["kind"].stringValue) else {
            throw WikidataEntryJSONError.invalidKind(rawKind: json["kind"].stringValue)
        }
        let kind = jsonKind.kind
        
        self.id = json["id"].stringValue
        self.rawKind = kind.rawValue
        self.burialPlotReference = json["burial_plot_reference"].stringValue
        self.commonsCategory = try realm.objectOrThrow(ofType: CommonsCategory.self, forPrimaryKey: json["commons_category"].stringValue)
        
        if kind == .graveOf {
            try json["date_of_birth"].assertType(type: .dictionary)
            try json["date_of_death"].assertType(type: .dictionary)
            try json["categories"].assertType(type: .array)
            
            self.dateOfBirth = try WikidataDate(json: json["date_of_birth"], wikidataEntry: self, kind: "birth", realm: realm)
            self.dateOfDeath = try WikidataDate(json: json["date_of_death"], wikidataEntry: self, kind: "death", realm: realm)
            try self.categories.append(objectsIn: json["categories"].arrayValue
                .map { categoryJSON in
                    try categoryJSON.assertType(type: .string)
                    return try realm.objectOrThrow(ofType: Category.self, forPrimaryKey: categoryJSON.stringValue)
                })
        }
        if kind == .grave {
            try json["grave_of"].assertType(type: .array)
            try self.graveOf.append(objectsIn: json["grave_of"].arrayValue
                .map { graveOfJSON in
                    try graveOfJSON.assertType(type: .string)
                    return try realm.objectOrThrow(ofType: WikidataEntry.self, forPrimaryKey: graveOfJSON.stringValue)
                })
        }
        
        realm.add(self)
        
        for (_, localizationJSON) in json["localizations"].dictionaryValue {
            _ = try LocalizedWikidataEntry(json: localizationJSON, wikidataEntry: self, realm: realm)
        }
    }
    
    enum JSONKind: String {
        case grave_of
        case grave
        case monument
        
        var kind: Kind {
            switch self {
            case .grave_of:
                return .graveOf
            case .grave:
                return .grave
            case .monument:
                return .monument
            }
        }
    }
    
}

enum WikidataEntryJSONError: Error {
    case invalidKind(rawKind: String)
}
