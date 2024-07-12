//
//  AddBookView.swift
//  Book Nerd
//
//  Created by Parth Antala on 2024-07-12.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    var isValid: Bool {
        if title.isEmpty || author.isEmpty {
            return false
        } else {
            for field in [title, author] {
                if field.trimmingCharacters(in: .whitespaces).isEmpty { return false }
            }
            return true
        }
    }
    
    let genres = ["Fantasy", "Horro", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                Form {
                    Section {
                        TextField("Name of book", text: $title)
                        TextField("Author's name", text: $author)
                        
                        Picker("Genre", selection: $genre) {
                            ForEach(genres, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 80)
                    }
                    .listRowBackground(Color.white.opacity(0.5))
                    
                    Section("Write a review") {
                        TextField("Review...", text: $review)
                        
                        Picker("Rating", selection: $rating) {
                            ForEach(1..<6) {
                                Text(String($0))
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .listRowBackground(Color.white.opacity(0.5))
                    
                    Section {
                        Button("Save") {
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date.now)
                            
                            modelContext.insert(newBook)
                            dismiss()
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.5))
                    .disabled(!isValid)
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Add Book")
            }
        }
    }
}



#Preview {
    AddBookView()
}
