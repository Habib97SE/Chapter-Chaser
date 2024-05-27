//
//  BookView.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-03-01.
//

import SwiftUI
import SwiftData

struct BookView: View {
    @Environment(\.modelContext) var modelContext
    @State var model: BookModel
    @State var book: Book
    @State var markAsFavorite: Bool = false
    @Query var books: [Book]
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Text(book.title)
                    Spacer()
                    Image(systemName: markAsFavorite ? "star.fill" : "star").foregroundColor(.blue)
                        .onTapGesture {
                            handleFavorite(favoriteBook: book)
                            markAsFavorite.toggle()
                        }
                }
                .padding()
                AsyncImage(url: model.getBookCover(coverId: book.coverId, coverSize: "M"))
                Text(ShowDescription())
                Text("ISBN: \(ShowISBN())")
            }
            .padding()
        }
        .task {
            try? await model.getBook(workdIdentifer: book.openLibraryWorkKey)
        }
        .onAppear {
            for fetchedBook in books {
                if fetchedBook.isbn13 == book.isbn13 {
                    markAsFavorite = true
                    break
                }
            }
        }
    }
    
    func handleFavorite (favoriteBook: Book) {
        for fetchedBook in books {
            if fetchedBook.isbn13 == favoriteBook.isbn13 {
                return
            }
        }
        if markAsFavorite {
            modelContext.delete(favoriteBook)
            print("\(favoriteBook.title) has been removed to favorites")
        } else {
            modelContext.insert(favoriteBook)
            print("\(favoriteBook.title) has been added from favorites")
        }
    }

    
    
    func ShowDescription() -> String {
        if !book.favoriteDescription.isEmpty {
            return book.favoriteDescription
        } else {
            if let entries = model.bookData?.entries {
                for entry in entries {
                    if let descriptionValue = entry.description?.value, !descriptionValue.isEmpty {
                        book.favoriteDescription = descriptionValue
                        return descriptionValue
                    }
                }
            }
        }
        book.favoriteDescription = "Description not available."
        return "Description not available."
    }
    
    func ShowISBN() -> String {
        if !book.isbn13.isEmpty {
            return book.isbn13
        } else {
            if let entries = model.bookData?.entries {
                for entry in entries {
                    if let isbn13 = entry.isbn13?.first, !isbn13.isEmpty {
                        book.isbn13 = isbn13
                        return isbn13
                    }
                }
            }
        }
        book.isbn13 = "ISBN not available."
        return "ISBN is not available."
    }

    

}


