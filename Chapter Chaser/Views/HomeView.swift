//
//  ContentView.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-02-28.
//


import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @State private var model = BookModel() // ViewModel
    @Query var subjects: [Subject]
    @State private var navigationPath = NavigationPath()
    @State private var subjectInput: String = ""
    @State private var searchPerformed = false
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack(path: $navigationPath) { // Use NavigationStack with the navigation path
            VStack {
                TextField("Enter subject", text: $subjectInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .submitLabel(.search)
                    .onSubmit {
                        searchPerformed = true // Indicate that a search has been performed
                        Task {
                            print(subjects)
                            if subjectInput.isEmpty {
                                let randomSubject: String = subjects.randomElement()?.title ?? ""
                                title = randomSubject
                                try await fetchBooks(subject: title)
                            }
                            title = subjectInput
                            try await fetchBooks(subject: subjectInput.lowercased())
                        }
                    }
                Spacer()
                if model.isLoading {
                    ProgressView()
                    Text("Loading ...")
                    Spacer()
                } else {
                    listOfWorks()
                }
            }
            .navigationTitle("Books in \(title)")
            .navigationDestination(for: Book.self) { book in
                BookView(model: model, book: book)
            }
            .padding()
        }
    }

    private func fetchBooks(subject: String) async {
        try? await model.getBooksBySubject(subject: subject)
    }

    @ViewBuilder
    private func listOfWorks() -> some View {
        let books = model.books
        if !books.isEmpty {
            List(books) { book in
                Button(action: {
                    navigateToBookView(with: book)
                }) {
                    bookRow(for: book)
                }
                .buttonStyle(PlainButtonStyle())
            }
        } else if searchPerformed {
            Text("No books available")
            Spacer()
        }
    }

    private func navigateToBookView(with book: Book) {
        navigationPath.append(book)
    }

    @ViewBuilder
    private func bookRow(for book: Book) -> some View {
        HStack {
            AsyncImage(url: model.getBookCover(coverId: book.coverId, coverSize: "S"))
                .frame(width: 100, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 5))

            VStack(alignment: .leading) {
                Text(book.title).font(.headline)
                Text(book.authors.joined(separator: ", ")).font(.subheadline)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    HomeView()
}


