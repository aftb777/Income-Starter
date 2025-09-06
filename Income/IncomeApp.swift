//
//  IncomeApp.swift
//  Income
//
//

import SwiftUI
import CoreData
import SwiftData

@main
struct IncomeApp: App {
    
    // create instance of DataManager (CoreData)
    let dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
            // Container for core data
            // Pass Core Data context (viewContext) to SwiftUI environment
            // Now ANY child view can access Core Data using @Environment(\.managedObjectContext)
                .environment(\.managedObjectContext, dataManager.container.viewContext)
            
            
            // MARK : Container for SwiftData
            // pass @Swift Model name.self here
                .modelContainer(for : [
                    TransactionModel.self
                ])
        }
    }
}
