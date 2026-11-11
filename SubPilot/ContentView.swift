import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: SubscriptionStore
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                SubscriptionListView(
                    subscriptions: $store.subscriptions,
                    filter: .all
                )
                .tabItem { Label("Все подписки", systemImage: "list.bullet") }
                .tag(0)
            }
            .navigationTitle("SubPilot - дневник подписок")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SubscriptionStore())
    }
}
