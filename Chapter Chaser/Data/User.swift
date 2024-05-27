//
//  User.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-03-04.
//

import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) let id = UUID().uuidString
    var firstName: String
    var lastName: String
    @Attribute(.unique) var emailAddress: String
    var city: String
    var state: String
    var country: String
    var phoneNumber: String
    var birthDate: String
    
    init(firstName: String, lastName: String, emailAddress: String, city: String, state: String, country: String, phoneNumber: String, birthDate: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.city = city
        self.state = state
        self.country = country
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
    }
}
