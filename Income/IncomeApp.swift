//
//  IncomeApp.swift
//  Income
//
//

import SwiftUI

@main
struct IncomeApp: App {
    
    // create instance of DataManager
    let dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
            // Pass Core Data context (viewContext) to SwiftUI environment
            // Now ANY child view can access Core Data using @Environment(\.managedObjectContext)
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}
