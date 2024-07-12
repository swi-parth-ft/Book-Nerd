//
//  ContentView.swift
//  Book Nerd
//
//  Created by Parth Antala on 2024-07-12.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    @State private var showingAddScreen = false
    @State private var showingDetails = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                
                List {
                    Section {
                        ForEach(books) { book in
                            NavigationLink(value: book) {
                                HStack {
                                    EmojiRatingView(rating: book.rating)
                                        .font(.largeTitle)
                                    
                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.headline)
                                        Text(book.author)
                                            .foregroundStyle(.secondary)
                                        
                                    }
                                    
                                    
                                }
                                
                                
                                
                                
                            }.listRowBackground(book.rating < 2 ? Color.red.opacity(0.3) : Color.white.opacity(0.5))
                        }
                        .onDelete(perform: deleteBooks)
                       
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Books")
                .navigationDestination(for: Book.self) { book in
                    DetailView(book: book)
                }
                
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Add book", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
