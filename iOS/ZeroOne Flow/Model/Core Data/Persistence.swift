// Copyright © 2021-2022 Ni Fu. All rights reserved.

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ZeroOne Flow")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                print("Failed to load Core Data \(error), \(error.userInfo)")
            }
        })
    }
}
