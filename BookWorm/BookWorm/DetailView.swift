//
//  DetailView.swift
//  BookWorm
//
//  Created by FZJ on 2024/5/16.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var showingDelete = false
    
    let book: Book
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter
        }()
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()

                Text(book.genre)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
                .padding()
            Text(book.review)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
                .padding()
            Text(dateFormatter.string(from: book.date))
        }
        .navigationTitle(book.name)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("删除书籍", isPresented: $showingDelete) {
            Button("取消", role: .cancel) {}
            Button("确定", role: .destructive) {
                deleteBook()
            }
        } message: {
            Text("确定要删除吗？")
        }
        .toolbar {
            Button("delete", systemImage: "trash") {
                showingDelete = true
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
        let exmaple = Book(name: "《狮子王》", author: "冯梓健", genre: "儿童", review: "非常好的儿童书籍，使我的大拇指旋转", rating: 4, date: Date())
        return DetailView(book: exmaple)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
