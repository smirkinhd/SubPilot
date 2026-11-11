//
//  SubscriptionRow.swift
//  SubPilot
//
//  Created by Герман Смиркин on 12.11.2026.
//

import SwiftUI

struct SubscriptionRow: View {
    let subscription: Subscription

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(subscription.serviceName)
                    .font(.headline)
                Text(subscription.nextChargeDate, format: .dateTime.day().month().year())
                    .font(.subheadline)
                    .foregroundStyle(subscription.isUnpaid ? .red : .secondary)
            }
            Spacer()
            Text(subscription.price, format: .currency(code: "RUB"))
                .monospacedDigit()
                .foregroundStyle(subscription.isUnpaid ? .red : .primary)
        }
        .padding(.vertical, 4)
    }
}
