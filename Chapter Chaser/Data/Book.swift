//
//  Favorite.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-03-04.
//

import Foundation
import SwiftData

@Model
final class Book {
    @Attribute(.unique) let id = UUID().uuidString
    var title : String
    var favoriteDescription: String
    var coverId: Int
    var pagination: Int
    var authors: [String]
    var publisher: String
    var publishedDate: String
    var publishedPlaces: [String]
    var subject: String
    var isbn13: String
    var openLibraryWorkKey: String
    var isRead: Bool = false
    
    init(title: String, favoriteDescription: String, coverId: Int, pagination: Int, authors: [String], publisher: String, publishedDate: String, publishedPlaces: [String], subject: String, isbn13: String, openLibraryWorkKey: String) {
        self.title = title
        self.favoriteDescription = favoriteDescription
        self.coverId = coverId
        self.pagination = pagination
        self.authors = authors
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.publishedPlaces = publishedPlaces
        self.subject = subject
        self.isbn13 = isbn13
        self.openLibraryWorkKey = openLibraryWorkKey
    }
}
