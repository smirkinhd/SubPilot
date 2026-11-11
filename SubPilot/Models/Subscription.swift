import Foundation

struct Subscription: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var serviceName: String
    var price: Double
    var nextChargeDate: Date

    var isUnpaid: Bool {
        nextChargeDate < Calendar.current.startOfDay(for: Date())
    }
}

/// Контейнер для сериализации в файл
struct SubPilotData: Codable {
    var subscriptions: [Subscription] = []
}
