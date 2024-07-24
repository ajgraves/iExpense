//
//  ContentView.swift
//  iExpense
//
//  Created by Aaron Graves on 7/21/24.
//

import SwiftUI
import Observation

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

struct ExpenseSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(item.amount < 100 ? item.amount < 10 ? .green : .indigo : .red)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            List {
                /*
                    We're not going to be using this anymore, we're going to call new views to split
                    the expenses into sections.
                 */
                /*ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundStyle(item.amount < 100 ? item.amount < 10 ? .green : .indigo : .red)
                    }
                }
                .onDelete(perform: removeItems)*/
                
                // Now we'r ecalling the new view
                ExpenseSection(title: "Business", expenses: expenses.businessItems, deleteItems: removeBusinessItems)
                
                ExpenseSection(title: "Personal", expenses: expenses.personalItems, deleteItems: removePersonalItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    /*func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }*/
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) { // function used to delete items in our list
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
}

#Preview {
    ContentView()
}
