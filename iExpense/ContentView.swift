//
//  ContentView.swift
//  iExpense
//
//  Created by Aaron Graves on 7/21/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var sortOrder = [
        SortDescriptor(\Expenses.date),
        SortDescriptor(\Expenses.name)
    ]
    
    //@State private var expenses = Expenses()
    //@Query(sort: sortOrder) var expenses: [Expenses]
    @Query var expenses: [Expenses]
    
    @State private var showingAddExpense = false
    
    @State private var filter = ""
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            ExpensesView(sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter", selection: $filter) {
                            
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\Expenses.name)
                                ])
                            
                            
                            Text("Amount (low to high)")
                                .tag([
                                    SortDescriptor(\Expenses.amount, order: .forward)
                                ])
                            
                            Text("Amount (high to low)")
                                .tag([
                                    SortDescriptor(\Expenses.amount, order: .reverse)
                                ])
                            
                            
                            /*Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\Expenses.amount)
                                ])
                            */
                             
                            Text("Default")
                                .tag([
                                    SortDescriptor(\Expenses.date),
                                    SortDescriptor(\Expenses.name)
                                ])
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    //Button("Add Expense", systemImage: "plus") {
                    NavigationLink(destination: AddView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            /*.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    /*Button("Add Expense", systemImage: "plus") {
                     showingAddExpense = true
                     }*/
                    NavigationLink(destination: AddView(expenses: expenses)) {
                        Image(systemName: "plus")
                    }
                }
            }*/
            /*.sheet(isPresented: $showingAddExpense) {
             AddView(expenses: expenses)
             }*/
        }
    }
    

    
    /*func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }*/
    /*func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) { // function used to delete items in our list
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
    }*/
}

#Preview {
    ContentView()
}
