//
//  Book_NerdApp.swift
//  Book Nerd
//
//  Created by Parth Antala on 2024-07-12.
//
import SwiftData
import SwiftUI

@main
struct Book_NerdApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
