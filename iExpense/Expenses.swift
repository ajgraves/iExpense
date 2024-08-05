//
//  Expenses.swift
//  iExpense
//
//  Created by Aaron Graves on 8/5/24.
//

import Foundation
import SwiftData

@Model
class Expenses {
    var id: UUID = UUID()
    var name: String
    var type: String
    var amount: Double
    var date: Date = Date.now
    
    init(name: String, type: String, amount: Double, date: Date) {
        self.name = name
        self.type = type
        self.amount = amount
        self.date = date
    }
}

/* This is all the old code
struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    // Let's take a stab at getting filtered lists of expenses
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }
    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business" }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from:                   savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
*/
