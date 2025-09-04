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

extension TransactionItem : Identifiable {

}
