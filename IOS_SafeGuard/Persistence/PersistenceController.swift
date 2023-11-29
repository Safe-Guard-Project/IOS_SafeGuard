//
//  PersistenceController.swift
//  IOS_SafeGuard
//
//  Created by Omar.Djebbi on 28/11/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "UserEntity") // Use the name of your Core Data model file
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

