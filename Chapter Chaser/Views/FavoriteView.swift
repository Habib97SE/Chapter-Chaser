//
//  FavoriteView.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-03-04.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    @State var searchInput: String = ""
    @State private var showReadMessage = false
    @State private var messageText = ""
    var body: some View {
        NavigationStack {
            Text("Here you can see a list of your favorite books, if you have read a book so you can tap on it to mark it as read. If you have not read so you can just tap again to mark it as unread. ")
                .padding()
            
            List {
                ForEach(books) { book in
                    HStack {
                        AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/id/\(book.coverId)-S.jpg"))
                        VStack {
                            Text(book.title).font(.title3)
                            Text(book.authors.joined(separator: ", "))
                        }
                        Spacer()
                        Image(systemName: book.isRead ? "checkmark.circle" : "circle").foregroundColor(book.isRead ? .green : .blue)
                    }
                    .onTapGesture {
                        book.isRead.toggle()
                        
                    }
                    
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        modelContext.delete(books[index])
                    }
                })
            }
            .navigationTitle("Favorite books"		)
        }
        
    }
    
    
    
}

#Preview {
    FavoriteView()
}
