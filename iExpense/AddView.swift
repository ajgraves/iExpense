//
//  AddView.swift
//  iExpense
//
//  Created by Aaron Graves on 7/22/24.
//

//import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = "New Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var date = Date.now
    
    //var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                //TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                
                DatePicker("Select a date", selection: $date, in: ...Date.now)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newExpense = Expenses(name: name, type: type, amount: amount, date: date)
                        modelContext.insert(newExpense)
                        dismiss()
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AddView()
}
