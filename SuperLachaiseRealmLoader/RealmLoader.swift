//
//  RealmLoader.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation
import RealmSwift

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
        if fm.fileExists(atPath: outDir.path) {
            try fm.removeItem(at: outDir)
        }
        try fm.createDirectory(at: outDir, withIntermediateDirectories: false, attributes: nil)
        let realmURL = outDir.appendingPathComponent("SuperLachaise.realm", isDirectory: false)
        Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: realmURL)
        _ = try Realm()
    }
    
}

enum RealmLoaderError: Error {
    case projectDirNotFound
}
