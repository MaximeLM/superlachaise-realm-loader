//
//  RealmLoader.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift
import SwiftyJSON

class RealmLoader {
    
    let inDir: URL
    let outDir: URL
    
    init() throws {
        guard let projectPath = Bundle.main.object(forInfoDictionaryKey: "ProjectDir") as? String else {
            throw RealmLoaderError.projectDirNotFound
        }
        let projectDir = URL(fileURLWithPath: projectPath, isDirectory: true)
        self.inDir = projectDir.appendingPathComponent("in", isDirectory: true)
        self.outDir = projectDir.appendingPathComponent("out", isDirectory: true)
    }
    
    func load() throws {
        // Create Realm
        let fm = FileManager.default
        try fm.createDirectory(at: outDir, withIntermediateDirectories: true, attributes: nil)
        let realmURL = outDir.appendingPathComponent("SuperLachaise.realm", isDirectory: false)
        Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: realmURL)
        let realm = try Realm()
        
        try realm.write {
            realm.deleteAll()
            try loadAllFiles(realm: realm)
        }
    }
    
    enum File: String {
        case categories
        case commons_files
        case commons_categories
        case wikipedia_pages
        case wikidata_entries
        case openstreetmap_elements
        
        static let all: [File] = [
            .categories,
            .commons_files,
            .commons_categories,
            .wikipedia_pages,
            .wikidata_entries,
            .openstreetmap_elements,
        ]
    }
    
    func loadAllFiles(realm: Realm) throws {
        for file in File.all {
            try loadFile(file: file, realm: realm)
        }
    }
    
    func loadFile(file: File, realm: Realm) throws {
        let fileURL = inDir.appendingPathComponent(file.rawValue, isDirectory: false)
        let fileJSON = try JSON(fileURL: fileURL)
        try fileJSON[file.rawValue].assertType(type: .dictionary)
        for (_, json) in fileJSON[file.rawValue].dictionaryValue {
            try json.assertType(type: .dictionary)
            switch file {
            case .categories:
                _ = try Category(json: json, realm: realm)
            case .commons_files:
                _ = try CommonsFile(json: json, realm: realm)
            case .commons_categories:
                _ = try CommonsCategory(json: json, realm: realm)
            case .wikipedia_pages:
                _ = try WikipediaPage(json: json, realm: realm)
            case .wikidata_entries:
                _ = try WikidataEntry(json: json, realm: realm)
            case .openstreetmap_elements:
                _ = try OpenStreetMapElement(json: json, realm: realm)
            }
        }
    }
    
}

enum RealmLoaderError: Error {
    case projectDirNotFound
}
