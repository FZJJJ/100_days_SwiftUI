//
//  Book.swift
//  BookWorm
//
//  Created by FZJ on 2024/5/15.
//

import SwiftData
import Foundation

@Model
class Book {
    var name: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: Date
    init(name: String, author: String, genre: String, review: String, rating: Int, date: Date) {
        self.name = name
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}
