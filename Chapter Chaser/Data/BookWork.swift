struct BookWork: Decodable {
    let key: String
    let name: String
    let subject_type: String
    let workCount: Int
    let works: [Work]

    enum CodingKeys: String, CodingKey {
        case key, name, subject_type = "subject_type", workCount = "work_count", works
    }
}

struct Work: Decodable, Hashable {
    let key: String
    let title: String
    let editionCount: Int
    let cover_id: Int
    let coverEditionKey: String?
    let subject: [String]
    let iaCollection: [String]
    let authors: [Author]
    let firstPublishYear: Int
    let ia: String?
    let publicScan: Bool
    let hasFulltext: Bool
    let availability: Availability?

    enum CodingKeys: String, CodingKey {
        case key, title, editionCount = "edition_count", cover_id, coverEditionKey = "cover_edition_key", subject, iaCollection = "ia_collection", authors, firstPublishYear = "first_publish_year", ia, publicScan = "public_scan", hasFulltext = "has_fulltext", availability
    }
}

struct Author: Decodable, Hashable {
    let key: String
    let name: String
}

struct Availability: Decodable, Hashable {
    let status: String
    let availableToBrowse: Bool?
    let availableToBorrow: Bool?
    let availableToWaitlist: Bool?
    let isPrintdisabled: Bool?
    let isReadable: Bool?
    let isLendable: Bool?
    let isPreviewable: Bool?
    let identifier: String?
    let isbn: String?
    let openlibraryWork: String?
    let openlibraryEdition: String?
    let lastLoanDate: String?
    let numWaitlist: String?
    let lastWaitingDate: String?
    let isRestricted: Bool?
    let isBrowseable: Bool?

    enum CodingKeys: String, CodingKey {
        case status, availableToBrowse = "available_to_browse", availableToBorrow = "available_to_borrow", availableToWaitlist = "available_to_waitlist", isPrintdisabled = "is_printdisabled", isReadable = "is_readable", isLendable = "is_lendable", isPreviewable = "is_previewable", identifier, isbn, openlibraryWork = "openlibrary_work", openlibraryEdition = "openlibrary_edition", lastLoanDate = "last_loan_date", numWaitlist = "num_waitlist", lastWaitingDate = "last_waiting_date", isRestricted = "is_restricted", isBrowseable = "is_browseable"
    }
}
