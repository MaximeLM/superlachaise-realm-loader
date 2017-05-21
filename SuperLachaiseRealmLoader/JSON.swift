//
//  JSON.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import SwiftyJSON

extension JSON {
    
    init(fileURL: URL) throws {
        var error: NSError?
        self.init(data: try Data(contentsOf: fileURL), error: &error)
        if let error = error {
            throw error
        }
    }
    
    func assertType(type: Type) throws {
        guard self.type == type else {
            assertionFailure()
            throw JSONError.invalidType(json: self, expected: type)
        }
    }
    
}

enum JSONError: Error {
    case invalidType(json: JSON, expected: Type)
}
