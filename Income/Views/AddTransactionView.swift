//
//  AddTransactionView.swift
//  Income
//
//

import SwiftUI

struct AddTransactionView: View {
    @State private var amount = 0.0
    @State private var transactionTitle = ""
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @Binding var transactions: [Transaction]
    var transactionToEdit: Transaction?
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @AppStorage("currency") var currency = Currency.usd
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Rectangle()
                .fill(Color(uiColor: UIColor.lightGray))
                .frame(height: 0.5)
                .padding(.horizontal, 30)
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            Button(action: {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be 2 or more characters long."
                    showAlert = true
                    return
                }
                //correction here. When editing the last date should be used
//                let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                
                if let transactionToEdit = transactionToEdit {
                    guard let indexOfTransaction = transactions.firstIndex(of: transactionToEdit) else {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                    let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: transactionToEdit.date)
                    transactions[indexOfTransaction] = transaction
                } else {
                    
                    let transaction = TransactionItem(context: viewContext)
                    transaction.id = UUID()
                    transaction.title = transactionTitle
                    transaction.type = Int16(selectedTransactionType.rawValue)
                    transaction.amount = Double(amount)
                    transaction.date = Date()
                    
                    do {
                        try viewContext.save()
                    } catch {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                    
//                    let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
//                    transactions.append(transaction)
                }
                
                dismiss()
                
            }, label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    
            })
            .padding(.top)
            .padding(.horizontal, 30)
            Spacer()
        }
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.title
                selectedTransactionType = transactionToEdit.type
            }
        })
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button(action: {
                
            }, label: {
                Text("OK")
            })
        } message: {
            Text(alertMessage)
        }

    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
