//
//  DataManager.swift
//  Income
//
//  Created by Aftaab Mulla on 04/09/25.
//

import Foundation
import CoreData

// This class will manage Core Data (like a helper / manager)
class DataManager {
    
    // The main Core Data box (Persistent Container)
    // "Income" should be the same name as your Core Data model file (.xcdatamodeld)
    let container = NSPersistentContainer(name: "Income Data")
    
    // When DataManager is created, this code runs automatically
    init() {
        // Load the actual database (persistent store)
        container.loadPersistentStores { storeDescription, error in
            
            // If there is an error while loading the database
            if let error = error {
                // Print the error in console
                print(error.localizedDescription)
            }
            
            // If no error, Core Data is ready to use
        }
    }
}
