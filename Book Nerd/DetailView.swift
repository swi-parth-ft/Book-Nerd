//
//  DetailView.swift
//  Book Nerd
//
//  Created by Parth Antala on 2024-07-12.
//
import SwiftData
import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView{
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.black.opacity(0.9))
                        .opacity(0.4)
                        .shadow(radius: 15)
                        .frame(width: 350, height: 200)
                    
                    Image("\(book.genre)")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(30)
                        .ignoresSafeArea()
                        .frame(width: 320, height: 250)
                        .shadow(radius: 5)
                        
                    
                    Text(book.genre.uppercased())
                        .fontWeight(.black)
                        .padding()
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(.capsule)
                        .offset(x: -5, y: -5)
                    
                }
                
                RatingView(rating: .constant(book.rating))
                    .font(.largeTitle)
                    .shadow(radius: 5)
                    .padding()
                
                VStack {
                    
                    Text(book.title)
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                    Text(book.author)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
                
                
                    
                
                VStack {
                    Text(book.review)
                    Text("Reviewed On: \(book.date.formattedDate()) \(book.date.formattedTime())")
                        .foregroundStyle(.secondary)
                }
                .padding()
                
                
                
                
            }
            .navigationTitle(book.title)
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .alert("Delete book", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive, action: deleteBook)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure?")
            }
            .toolbar {
                Button("Delete this book", systemImage: "trash") {
                    showingDeleteAlert = true
                }
            }
        }
    }
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4, date: Date.now)
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    
}
