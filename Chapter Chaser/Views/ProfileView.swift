//
//  ProfileView.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-03-04.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    @Query var subjects: [Subject]
    @State private var newSubject: String = ""
    @State private var errorMessageNewSubject: String = ""
    var body: some View {
  
            List {
                Section(header: Text("Personal Details")) {
                    HStack {
                        Text("Name:").fontWeight(.light)
                        Text("\(users[0].firstName) \(users[0].lastName)").fontWeight(.bold)
                    }
                    HStack {
                        Text("Email:").fontWeight(.light)
                        Text("\(users[0].emailAddress)").fontWeight(.bold)
                    }
                    HStack {
                        Text("Phone:").fontWeight(.light)
                        Text("\(users[0].phoneNumber)").fontWeight(.bold)
                    }
                    HStack {
                        Text("Location: ").fontWeight(.light)
                        Text("\(users[0].city) \(users[0].country)").fontWeight(.bold)
                    }
                    
                }
                
                Section(header: Text("Your favorite subjects")) {
                    ForEach(subjects, id: \.self) { subject in
                        let subjectTitle = subject.title.capitalized
                        
                        Text("\(subjectTitle)")
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            modelContext.delete(subjects[index])
                        }
                    })
                    HStack {
                        TextField("Add new subject", text: $newSubject)
                            .onSubmit {
                                if newSubject.isEmpty {
                                    errorMessageNewSubject = "The subject field cannot be empty."
                                    return
                                }
                                errorMessageNewSubject = ""
                                let newSubjectElement = Subject(title: newSubject, subjectDescription: "")
                                modelContext.insert(newSubjectElement)
                                newSubject = ""
                        }
                        Image(systemName: "plus.circle").foregroundColor(.green)
                            .onTapGesture {
                                if newSubject.isEmpty {
                                    errorMessageNewSubject = "The subject field cannot be empty."
                                    return
                                }
                                errorMessageNewSubject = ""
                                let newSubjectElement = Subject(title: newSubject, subjectDescription: "")
                                modelContext.insert(newSubjectElement)
                                newSubject = ""
                            }
                    }
                    if !errorMessageNewSubject.isEmpty {
                        Text(errorMessageNewSubject).foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        
            
        
    }
}
