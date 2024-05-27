//
//  Subject.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-03-04.
//

import Foundation
import SwiftData

@Model
final class Subject {
    @Attribute(.unique) let id: String = UUID().uuidString
    var title: String
    var subjectDescription: String
    init(title: String, subjectDescription: String) {
        self.title = title
        self.subjectDescription = subjectDescription
    }
}
