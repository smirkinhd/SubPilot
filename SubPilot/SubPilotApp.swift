//
//  SubPilotApp.swift
//  SubPilot
//
//  Created by Герман Смиркин on 11.11.2026.
//

import SwiftUI

@main
struct SubPilotApp: App {
    @StateObject private var store = SubscriptionStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
