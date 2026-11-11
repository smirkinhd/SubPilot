//
//  ContentView.swift
//  SubPilot
//
//  Created by Герман Смиркин on 11.11.2026.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: SubPilotDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(SubPilotDocument()))
    }
}
