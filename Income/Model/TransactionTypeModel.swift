//
//  TransactionTypeModel.swift
//  Income
//
//

import Foundation
import RealmSwift

enum TransactionType: Int, CaseIterable, Identifiable, Codable, PersistableEnum {
    case income, expense
    var id: Self { self }
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
