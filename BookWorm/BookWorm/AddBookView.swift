//
//  AddBookView.swift
//  BookWorm
//
//  Created by FZJ on 2024/5/15.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    @State private var date = Date()
    
    @State private var showingAlert = false
    
    let genres = ["奇幻", "恐怖", "儿童", "神秘", "诗歌", "浪漫", "惊悚"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("书籍名称", text: $name)
                    TextField("作者姓名", text: $author)
                    Picker("类型", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("评价") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("保存") {
                        if !(name.isEmpty || author.isEmpty || review.isEmpty) {
                            let newbook = Book(name: name, author: author, genre: genre, review: review, rating: rating, date: date)
                            modelContext.insert(newbook)
                            dismiss()
                        } else {
                            showingAlert = true
                        }
                    }
                }
            }
            .navigationTitle("添加书籍")
            .alert("有误！", isPresented: $showingAlert) {
                Button("好的") {}
            } message: {
                Text("请仔细完成填写")
            }
        }
    }
}

#Preview {
    AddBookView()
}
