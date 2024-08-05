//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Aaron Graves on 7/21/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expenses.self)
    }
}
