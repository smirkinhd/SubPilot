//
//  SubscriptionListView.swift
//  SubPilot
//
//  Created by Герман Смиркин on 12.11.2026.
//

import SwiftUI

enum SubscriptionFilter {
    case all
    case unpaid
}

struct SubscriptionListView: View {
    @EnvironmentObject var store: SubscriptionStore
    @Binding var subscriptions: [Subscription]
    let filter: SubscriptionFilter

    @State private var isShowingAddSheet = false

    private var filtered: [Subscription] {
        switch filter {
        case .all:
            return subscriptions.sorted { $0.nextChargeDate < $1.nextChargeDate }
        case .unpaid:
            return subscriptions.filter(\.isUnpaid)
                .sorted { $0.nextChargeDate < $1.nextChargeDate }
        }
    }

    private var totalMonthly: Double {
        filtered.reduce(0) { $0 + $1.price }
    }

    private var nextCharge: (date: Date, amount: Double)? {
        filtered.min { $0.nextChargeDate < $1.nextChargeDate }
            .map { ($0.nextChargeDate, $0.price) }
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()

            if filtered.isEmpty {
                Spacer()
                Text(filter == .all ? "Нет подписок" : "Нет неоплаченных подписок")
                    .foregroundStyle(.secondary)
                Spacer()
            } else {
                List {
                    ForEach(filtered) { sub in
                        SubscriptionRow(subscription: sub)
                    }
                    .onDelete { indexSet in
                        delete(at: indexSet)
                    }
                }
                .listStyle(.inset)
            }
        }
        .sheet(isPresented: $isShowingAddSheet) {
            AddSubscriptionView { newSub in
                store.subscriptions.append(newSub)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Итого:")
                    .font(.headline)

                Spacer()

                Text(totalMonthly, format: .currency(code: "RUB"))
                    .font(.title3.bold())

                Button {
                    isShowingAddSheet = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .padding(.leading, 8)
                }
                .buttonStyle(.plain)
            }

            if let nextCharge {
                HStack {
                    Text("Ближайшее списание:")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(nextCharge.amount, format: .currency(code: "RUB")) · \(nextCharge.date, format: .dateTime.day().month().year())")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(.thinMaterial)
    }

    private func delete(at offsets: IndexSet) {
        let idsToDelete = offsets.map { filtered[$0].id }
        subscriptions.removeAll { idsToDelete.contains($0.id) }
    }
}
