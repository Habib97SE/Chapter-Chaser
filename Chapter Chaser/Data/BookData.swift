import Foundation




struct BookData: Decodable {
    let links: Links
    let size: Int
    let entries: [Entry]
}

struct Links: Decodable {
    let workSelf: String
    let work: String
    let next: String
    
    enum CodingKeys: String, CodingKey {
        case workSelf = "self"
        case work
        case next
    }
}

struct Entry: Decodable{    
    let title: String
    let subtitle: String?
    let publishers: [String]?
    let covers: [Int]?
    let isbn13: [String]?
    let publishPlaces: [String]?
    let publishDate: String?
    let contributors: [Contributor]?
    let languages: [Language]?
    let physicalFormat: String?
    let latestRevision: Int?
    let revision: Int?
    let description: Description?
    let pagination: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case publishers
        case covers
        case isbn13 = "isbn_13"
        case publishPlaces = "publish_places"
        case publishDate = "publish_date"
        case contributors
        case languages
        case physicalFormat = "physical_format"
        case latestRevision = "latest_revision"
        case revision
        case description
        case pagination
    }
}

struct Contributor: Decodable {
    let role: String
    let name: String
}

struct Language: Decodable {
    let key: String
}

struct Description: Decodable {
    let type: String
    let value: String
}
