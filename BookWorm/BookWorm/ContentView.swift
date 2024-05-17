//
//  ContentView.swift
//  BookWorm
//
//  Created by FZJ on 2024/5/15.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort:[
        SortDescriptor(\Book.name),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) {book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.name)
                                    .font(.headline)
                                    .foregroundStyle(book.rating == 1 ? .red : .black)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("书籍库")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("add book", systemImage: "plus") {
                        showingAddView.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddBookView()
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
