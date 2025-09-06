//
//  TransactionTypeModel.swift
//  Income
//
//

import Foundation

enum TransactionType: Int, CaseIterable, Identifiable, Codable {
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
