//
//  TransactionItem+CoreDataProperties.swift
//  Income
//
//  Created by Aftaab Mulla on 04/09/25.
//
//

import Foundation
import CoreData


extension TransactionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionItem> {
        return NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: Int16
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?

}


// Helper function which will create fetch request for transaction item

extension TransactionItem : Identifiable {

}


//Core Data makes properties optional (like String?, UUID?).
//
//Using wrappers gives them safe default values.
//
//Avoids crashes from nil and no need for ?? or ! everywhere.
//
//Makes UI code cleaner and safer. ✅

extension TransactionItem {
    
    var wrappedId : UUID {
        
        // return id ?? UUID() safe method no risk
        
        return id! // id! = “I’m 100% sure this is not nil. If it’s nil, app will crash.”
    }
    
    var wrappedTitle : String {
        return title ?? "" // if title has value return it else return empty string ""
    }
    
    var wrappedDate : Date {
        return date ?? Date() // if date exists return it else use currentDate
    }
    
    var wrappedType : TransactionType{
        return TransactionType(rawValue: Int(type)) ?? .expense
        // take expense as default
    }
    
    var wrappedAmount : Double {
        return amount
        // amount is not optional so no need of ??
    }
    
    // MARK we cannont use !(force unwrapping) to non Optionals
}
