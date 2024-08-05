//
//  ExpensesView.swift
//  iExpense
//
//  Created by Aaron Graves on 8/5/24.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expenses]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    Image(systemName: expense.type == "Business" ? "building.columns" : "house")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        
                        Text(expense.date.formatted(date: .numeric, time: .shortened))
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(expense.amount < 100 ? expense.amount < 10 ? .green : .indigo : .red)
                }
            }
            .onDelete(perform: deleteExpenses)
        }
    }
    
    init(sortOrder: [SortDescriptor<Expenses>]) {
        _expenses = Query(sort: sortOrder)
    }
    
    func deleteExpenses(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpensesView(sortOrder: [SortDescriptor(\Expenses.name)])
        .modelContainer(for: Expenses.self)
}
