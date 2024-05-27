//
//  RegisterView.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-03-13.
//


//user.firstName = firstName
//user.lastName = lastName
//user.birthDate = birthDate
//user.emailAddress = email
//user.phoneNumber = phone
//user.city = city
//user.country = country


import SwiftUI
import SwiftData

struct RegisterView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var isFirstTime: Bool
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var birthDate: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var city: String = ""
    @State private var country: String = ""
    @State private var favoriteSubjectString: String = ""
    @State private var favoriteSubjects: [String] = []
    @State private var error: Bool = true
    @State private var message: String = ""
    
    var body: some View {
            VStack {
                Form {
                    Section(header: Text("Your personal details")) {
                        TextField("First name", text: $firstName)
                        TextField("Last name", text: $lastName)
                        TextField("Birth date", text: $birthDate)
                    }
                    Section(header: Text("Communication way")) {
                        TextField("Email address", text: $email)
                        TextField("Phone number", text: $phone)
                    }
                    Section(header: Text("Where do you live?")) {
                        TextField("City", text: $city)
                        TextField("Country", text: $country)
                    }
                    Section(header: Text("Add your favorite subjects (separate them by comma ,)")) {
                        TextEditor(text: $favoriteSubjectString)
                    }
                    Section {
                        Button(action: {
                            let result = formIsValid(firstName: firstName, lastName: lastName, email: email, phone: phone, city: city, country: country)
                            if result.isValid {
                                error = false
                                
                                // Add user to the modelContext
                                let user = User(firstName: firstName, lastName: lastName, emailAddress: email, city: city, state: "", country: country, phoneNumber: phone, birthDate: birthDate)
                               
                                modelContext.insert(user)
                                
                                // Add subjects to the modelContext
                                let subjects = splitStringToArray(str: favoriteSubjectString, separator: ",")
                                for subject in subjects {
                                    let newSubject = Subject(title: subject, subjectDescription: "")
                                    modelContext.insert(newSubject)
                                }
                                
                                
                                // Change the value to re-render the content view
                                self.isFirstTime = false
                            } else {
                                error = true
                            }
                            message = result.message
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Submit").font(.title)
                                Image(systemName: "chevron.right")
                                Spacer()
                            }
                            .padding()
                        })
                    }
                    if error {
                        Section {
                            Text("\(message)").foregroundColor(.red)
                        }
                    }
                    else {
                        Section {
                            Text("\(message)").foregroundColor(.green)
                        }
                    }
                }
            }
            .padding()
    }
}

func formIsValid (firstName: String, lastName: String, email: String, phone: String, city: String, country: String) -> (isValid: Bool, message: String) {
    // Check if all fields are filld.
    if firstName.isEmpty || lastName.isEmpty || email.isEmpty || phone.isEmpty || city.isEmpty || country.isEmpty {
        return (false, "All fields are required.")
    }
    // Email Validation
    if !email.contains("@") {
        return (false, "Email is not valid. Please double check")
    }
    return (true, "All fields are valid.")
}

func splitStringToArray (str: String, separator: Character) -> [String] {
    let subjectsArray = str.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
    return subjectsArray
}

