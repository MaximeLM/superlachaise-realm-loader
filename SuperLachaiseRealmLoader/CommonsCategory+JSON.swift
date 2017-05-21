//
//  CommonsCategory+JSON.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

extension CommonsCategory {
    
    convenience init(json: JSON, realm: Realm) throws {
        self.init()
        
        try json["id"].assertType(type: .string)
        try json["commons_files"].assertType(type: .array)
        
        self.id = json["id"].stringValue
        try self.commonsFiles.append(objectsIn: json["commons_files"].arrayValue
            .map { commonsFileJSON in
                try commonsFileJSON.assertType(type: .string)
                return try realm.objectOrThrow(ofType: CommonsFile.self, forPrimaryKey: commonsFileJSON.stringValue)
            })
        
        realm.add(self)
    }
    
}
