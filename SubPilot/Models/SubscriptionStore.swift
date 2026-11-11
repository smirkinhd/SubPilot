import Foundation
import Combine

class SubscriptionStore: ObservableObject {
    @Published var subscriptions: [Subscription] = [] {
        didSet { save() }
    }

    private let fileURL: URL = {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("subscriptions.json")
    }()

    init() {
        load()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([Subscription].self, from: data) else {
            return
        }
        subscriptions = decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(subscriptions) else { return }
        try? data.write(to: fileURL)
    }
}
