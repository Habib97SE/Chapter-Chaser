import Foundation
import SwiftUI
import Observation


@Observable
class BookModel {
    let baseUrl = "https://openlibrary.org"
    var books: [Book] = []
    var bookWorks: [BookWork] = []
     var isLoading: Bool = false
     var bookData: BookData?
     var bookDetailIsLoading: Bool = false
    
    func getBooksBySubject(subject: String) async throws {
        if self.books.count > 0 {
            return
        }
        isLoading = true
        let endpoint = "/subjects/\(subject).json"
        print("\(baseUrl)\(endpoint)")
        guard let url = URL(string: baseUrl + endpoint) else {
            isLoading = false
            return
        }
        let (data, _) = try await URLSession.shared.data(from: url)
       
        do {
            let decoder = JSONDecoder()
            let bookWorks = try decoder.decode(BookWork.self, from: data)
            for work in bookWorks.works {
                let book = Book(
                    title: work.title,
                    favoriteDescription: "",
                    coverId: work.cover_id,
                    pagination: 0,
                    authors: work.authors.map { author -> String in return author.name},
                    publisher: "",
                    publishedDate: String(work.firstPublishYear),
                    publishedPlaces: [""],
                    subject: subject,
                    isbn13: work.availability?.isbn ?? "",
                    openLibraryWorkKey: work.key
                )
                books.append(book)
            }
        } catch {
            print(error)
        }
        
        isLoading = false
    }
    
    func getBook(workdIdentifer: String) async throws {
        self.bookDetailIsLoading = true
        let endpoint = "\(workdIdentifer)/editions.json"
        guard let url = URL(string: baseUrl + endpoint) else {
            bookDetailIsLoading = false
            return
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        DispatchQueue.main.async {
            do {
                let decoder = JSONDecoder()
                self.bookData = try decoder.decode(BookData.self, from: data)
            } catch {
                print(error)
            }
        }
        self.bookDetailIsLoading = false
    }
    
    func getBookCover(coverId: Int, coverSize: String) -> URL? {
        let endpoint = "https://covers.openlibrary.org/b/id/\(coverId)-\(coverSize).jpg"
        return URL(string: endpoint)
    }
    
    func getLanguage(workKey: String) async throws -> String
    {
        let endpoint = "\(workKey)/editions.json"
        guard let url = URL(string: baseUrl + endpoint) else { return "" }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let newBookData: BookData = try JSONDecoder().decode(BookData.self, from: data)
            let languageKey = newBookData.entries[0].languages?.first?.key
            guard let languageUrl = URL(string: "\(baseUrl)\(String(describing: languageKey)).json") else { return "" }
            let (languageData, _) = try await URLSession.shared.data(from: languageUrl)
            do {
                let decoder = JSONDecoder()
                let language: LanguageData = try decoder.decode(LanguageData.self, from: languageData)
                return language.name
            } catch {
                print(error)
            }
            
        } catch {
            print(error)
        }
        return ""
    }
    
    
    func search(searchPhrase: String, page: Int, limit: Int = 10) async throws -> Search? {
        let offset = (page - 1) * limit
        var newSearchPhrase = searchPhrase.replacingOccurrences(of: " ", with: "+")
        let endpoint = "/search.json?q=\(newSearchPhrase)&offset=\(offset)&limit=\(limit)"
        guard let url = URL(string: baseUrl + endpoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let decoder = JSONDecoder()
            let searchResults = try decoder.decode(Search.self, from: data)
            return searchResults
        } catch {
            print(error)
        }
        return nil
    }

    
}
