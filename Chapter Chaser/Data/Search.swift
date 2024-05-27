//
//  Search.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-03-09.
//

import Foundation


struct Search: Decodable {
    let numFound: Int
    let start: Int
    let numFoundExact: Bool
    let docs: [Document]
    enum CodingKeys: String, CodingKey {
        case numFound
        case start
        case numFoundExact
        case docs
    }
}

struct Document: Decodable {
    let authorAlternativeNames: [String]?
    let authorKey: [String]?
    let authorName: [String]?
    let coverEditionKey: String?
    let coverI : Int?
    let editionCount: Int?
    let editionKey: [String]?
    let firstPublishedYear: Int?
    let hasFulltext: Bool?
    let isbn: [String]?
    let key: String?
    let language: [String]?
    let numberOfPageMedian: Int?
    let publishedDate: [String]?
    let publishYear: [Int]?
    let publisher: [String]?
    let seed: [String]?
    let title: String?
    let titleSort: String?
    let titleSuggest: String?
    let subject: [String]?
    
    enum CodingKeys: String, CodingKey {
        case authorAlternativeNames = "author_alternative_name"
        case authorKey = "author_key"
        case authorName = "author_name"
        case coverEditionKey = "cover_edition_key"
        case coverI = "cover_i"
        case editionCount = "edition_count"
        case editionKey = "edition_key"
        case firstPublishedYear = "first_publish_year"
        case hasFulltext = "has_fulltext"
        case isbn
        case key
        case language
        case numberOfPageMedian = "number_of_pages_median"
        case publishedDate = "publish_date"
        case publishYear = "publish_year"
        case publisher
        case seed
        case title
        case titleSort = "title_sort"
        case titleSuggest = "title_suggest"
        case subject
    }
    
}

