//
//  SearchView.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-03-09.
//

import SwiftUI

struct SearchView: View {
    @State private var model = BookModel()
    @State private var searchInput: String = ""
    @State private var searchResults: Search? = nil
    @State private var currentPage: Int = 1
    @State private var isLoading: Bool = false
    @State private var navigationPath = NavigationPath()
    @State private var searchPerformed: Bool = false
    
    
    
    let itemsPerPage: Int = 10

    var body: some View {
            NavigationStack(path: $navigationPath) {
                VStack {
                    TextField("Search book", text: $searchInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .submitLabel(.search)
                        .onSubmit {
                            currentPage = 1 
                            searchPerformed = true
                            Task {
                                await performSearch(page: currentPage)
                            }
                        }
                    Spacer()
                    if isLoading {
                        ProgressView()
                        Text("Loading ...")
                        Spacer()
                    } else {
                        searchResultsView
                    }
                    paginationControls
                }
                .navigationTitle("Search Books")
                .navigationDestination(for: Book.self) { book in
                    BookView(model: model, book: book)
                }
                .padding()
            }
        }
    
    @ViewBuilder
    private var searchResultsView: some View {
        
        if let results = searchResults, results.numFound > 0 {
            Text("Total search result: \(results.numFound)")
            List(results.docs, id: \.key) { result in
                HStack {
                    AsyncImage(url: model.getBookCover(coverId: result.coverI ?? 0, coverSize: "S"))
                    VStack {
                        Text(result.title ?? "No title available").font(.title3)
                        Text("Authors: \(result.authorName?.joined(separator: ", ") ?? "No author available")")
                        Text("ISBN: \(result.isbn?.first ?? "No ISBN available")")
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    let book: Book = Book(
                        title: result.title ?? "",
                        favoriteDescription: "",
                        coverId: result.coverI ?? 0,
                        pagination: result.numberOfPageMedian ?? 0,
                        authors: result.authorName ?? [],
                        publisher: result.publisher?.first ?? "",
                        publishedDate: result.publishedDate?.first ?? "",
                        publishedPlaces: [],
                        subject: result.subject?.first ?? "",
                        isbn13: result.isbn?.first ?? "",
                        openLibraryWorkKey: getWorkKey(seed: result.seed ?? []))
                    navigationPath.append(book)
                }
            }
        } else if searchPerformed && !isLoading {
            Text("Nothing has been found.")
            Spacer()
        }
    }
    
    @ViewBuilder
    private var paginationControls: some View {
        HStack {
            Button("Previous") {
                guard currentPage > 1 else { return }
                currentPage -= 1
                Task {
                    await performSearch(page: currentPage)
                }
            }
            .disabled(currentPage <= 1 || isLoading)
            
            Spacer()
            
            Text("Page \(currentPage)")
            
            Spacer()
            
            Button("Next") {
                guard let totalResults = searchResults?.numFound, totalResults > currentPage * itemsPerPage else { return }
                currentPage += 1
                Task {
                    await performSearch(page: currentPage)
                }
            }
            .disabled((searchResults?.numFound ?? 0) <= currentPage * itemsPerPage || isLoading)
        }
    }
    
    func performSearch(page: Int) async {
        isLoading = true
        do {
            let results = try await model.search(searchPhrase: searchInput, page: page)
            self.searchResults = results
        } catch {
            print("Error performing search: \(error)")
            self.searchResults = nil
        }
        isLoading = false
    }
    
    func getWorkKey (seed: [String]) -> String {
        if seed.count == 0 {
            return ""
        }
        if seed.count == 1 {
            return seed.first ?? ""
        }
        for key in seed {
            if key.starts(with: "/works") {
                return key
            }
        }
        return seed.first ?? ""
    }
}





#Preview {
    SearchView()
}
