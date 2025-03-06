//
//  CoreDataManager.swift
//  ChatGPT9
//
//  Created by Petar Glisovic on 2/27/25.
//

import Foundation
import CoreData

class CoreDataManager {

    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()

    private init() {
        persistentContainer = NSPersistentContainer(name: "HistoryModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreDataManager failed to load store: \(error.localizedDescription)")
            }


        }
    }
}

