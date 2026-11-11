//
//  AddSubscriptionView.swift
//  SubPilot
//
//  Created by Герман Смиркин on 12.11.2026.
//

import SwiftUI

struct AddSubscriptionView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var priceText: String = ""
    @State private var date: Date = Date()

    var onAdd: (Subscription) -> Void

    private var price: Double? {
        Double(priceText.replacingOccurrences(of: ",", with: "."))
    }

    private var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        (price ?? 0) > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Сервис") {
                    TextField("Название сервиса", text: $name)
                }
                Section("Стоимость") {
                    TextField("Цена", text: $priceText)
                        .keyboardType(.decimalPad)
                }
                Section("Дата списания") {
                    DatePicker(
                        "Следующее списание",
                        selection: $date,
                        displayedComponents: .date
                    )
                }
            }
            .navigationTitle("Новая подписка")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Добавить") {
                        guard let price, isValid else { return }
                        onAdd(Subscription(
                            serviceName: name.trimmingCharacters(in: .whitespaces),
                            price: price,
                            nextChargeDate: date
                        ))
                        dismiss()
                    }
                    .disabled(!isValid)
                }
            }
            .frame(minWidth: 360, minHeight: 320)
        }
    }
}
