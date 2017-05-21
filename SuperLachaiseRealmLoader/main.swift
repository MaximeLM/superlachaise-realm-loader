//
//  main.swift
//  SuperLachaiseRealmLoader
//
//  Created by Maxime Le Moine on 21/05/2017.
//
//

import Foundation

do {
    try RealmLoader().load()
    print("✅ completed")
} catch {
    print("❌ \(error)")
    exit(1)
}
