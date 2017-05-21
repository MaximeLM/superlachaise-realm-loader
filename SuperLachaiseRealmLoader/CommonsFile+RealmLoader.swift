//
//  CommonsFile+RealmLoader.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension CommonsFile {
    
    convenience init(json: JSON, realm: Realm) throws {
        self.init()
        
        try json["id"].assertType(type: .string)
        try json["width"].assertType(type: .number)
        try json["height"].assertType(type: .number)
        try json["image_url"].assertType(type: .string)
        try json["thumbnail_url_template"].assertType(type: .string)
        
        self.id = json["id"].stringValue
        self.width = json["width"].intValue
        self.height = json["height"].intValue
        self.author = json["author"].string
        self.license = json["license"].string
        self.rawImageURL = json["image_url"].stringValue
        self.thumbnailURLTemplate = json["thumbnail_url_template"].stringValue
        
        realm.add(self)
    }
    
}
