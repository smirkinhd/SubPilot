//
//  SubPilotApp.swift
//  SubPilot
//
//  Created by Герман Смиркин on 11.11.2026.
//

import SwiftUI

@main
struct SubPilotApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: SubPilotDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
