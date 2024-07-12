//
//  ContentView.swift
//  Book Nerd
//
//  Created by Parth Antala on 2024-07-12.
//

import SwiftUI
struct buttonVire: View {
    @Binding var isOn: Bool
    
    var body: some View {
        VStack {
            Button("Tap me") {
                isOn.toggle()
            }
            
        }
    }
}
struct ContentView: View {
    
    @State private var isOn = false
    
    var body: some View {
        VStack {
            buttonVire(isOn: $isOn)
            Text(isOn ? "On" : "Off")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
