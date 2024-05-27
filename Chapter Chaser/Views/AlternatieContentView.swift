////
////  ContentView.swift
////  Chapter Chaser
////
////  Created by Habib Hezarehee on 2024-02-28.
////
//
//
//import SwiftUI
//import SwiftData
//
//
//struct AlternativeContentView: View {
//    @Environment(\.modelContext) var modelContext
//    @AppStorage("isFirstTime") var isFirstTime = true
//    @State var model = BookModel() // ViewModel
//    @State private var navigationPath = NavigationPath() // Manage navigation path
//
//    var body: some View {
//        if isFirstTime {
//            // Onboarding view goes here
//            OnboardingView(isFirstTime: $isFirstTime)
//        } else {
//            // Main TabView content as before
//            TabView {
//                Group {
//                    HomeView()
//                        .tabItem {
//                            Label("Home", systemImage: "globe")
//                        }
//                    FavoriteView()
//                        .tabItem {
//                            Label("Favorites", systemImage: "heart")
//                        }
//                    SearchView()
//                        .tabItem {
//                            Label("Search", systemImage: "magnifyingglass")
//                        }
//                    ProfileView() // Assuming you have a ProfileView for the user
//                        .tabItem {
//                            Label("Profile", systemImage: "person.crop.circle")
//                        }
//                }
//                .toolbarBackground(.indigo, for: .tabBar)
//                .toolbarBackground(.visible, for: .tabBar)
//                .toolbarColorScheme(.dark, for: .tabBar)
//            }
//        }
//    }
//}
//
//
//struct OnboardingView: View {
//    @Environment(\.modelContext) var modelContext
//    @Binding var isFirstTime: Bool
//    @State var firstName: String = ""
//    @State var lastName: String = ""
//    @State var email: String = ""
//    @State var city: String = ""
//    @State var country: String = ""
//    @State var phoneNumber: String = ""
//    @State var birthDate: String = ""
//    
//    @State private var selectedTab = 0
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            UserInfoEntryView(firstName: $firstName, lastName: $lastName, email: $email, city: $city, country: $country, phoneNumber: $phoneNumber, birthDate: $birthDate)
//                .tabItem { Text("User Info") }
//                .tag(0)
//            UserPreferencesView(onFinish: {
//                let user: User = User(firstName: firstName, lastName: lastName, emailAddress: email, city: city, state: "N/A", country: country, phoneNumber: phoneNumber, birthDate: birthDate)
//                modelContext.insert(user)
//                isFirstTime = false
//                print("seeting isFirstTime to: \(isFirstTime)")
//            })
//            .tabItem { Text("Preferences") }
//            .tag(1)
//        }
//    }
//}
//
//struct UserInfoEntryView: View {
//    @Binding var firstName: String
//    @Binding var lastName: String
//    @Binding var email: String
//    @Binding var city: String
//    @Binding var country: String
//    @Binding var phoneNumber: String
//    @Binding var birthDate: String
//    @State var errorMessage: String = ""
//
//    var body: some View {
//        // User input fields for name and email
//        NavigationStack {
//            Text("Please enter your informaiton below (We don't store or share your informaiton.")
//            Form {
//                TextField("Firstname", text: $firstName)
//                TextField("Lastname", text: $lastName)
//                TextField("Email", text: $email)
//                TextField("City", text: $city)
//                TextField("Country", text: $country)
//                TextField("Phone number", text: $phoneNumber)
//                TextField("Birth date", text: $birthDate)
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || city.isEmpty || country.isEmpty || phoneNumber.isEmpty || birthDate.isEmpty {
//                            errorMessage = "All fields are required. Please double check and try again."
//                            return
//                        } else {
//                            errorMessage = "Your account has been created."
//                        }
//                        
//                    }, label: {
//                        HStack {
//                            Text("Submit")
//                            Image(systemName: "chevron.right")
//                        }.foregroundColor(.white)
//                    })
//                    .padding()
//                    .background(Color(red: 0, green: 0, blue: 0.5))
//                    .clipShape(Capsule())
//                    Spacer()
//                }
//                if !errorMessage.isEmpty {
//                    Text("\(errorMessage)").foregroundColor(.red)
//                }
//            }
//        }
//        .navigationTitle("Create new account")
//    }
//}
//
//struct UserPreferencesView: View {
//    var onFinish: () -> Void
//
//    @Environment(\.modelContext) var modelContext
//
//    @State var topFiveFavoriteSubjects: [String] = []
//    @State var firstSubject: String = ""
//    @State var secondSubject: String = ""
//    @State var thirdSubject: String = ""
//    @State var forthSubject: String = ""
//    @State var fifthSubject: String = ""
//    @State var errorMessage: String = ""
//    var body: some View {
//        VStack {
//            Text("Enter your top five faovrite subjects")
//            Form {
//                TextField("1st subject", text: $firstSubject)
//                TextField("2nd subject", text: $secondSubject)
//                TextField("3rd subject", text: $thirdSubject)
//                TextField("4th subject", text: $forthSubject)
//                TextField("5th subject", text: $fifthSubject)
//            }
//            Button(action: {
//                if firstSubject.isEmpty || secondSubject.isEmpty || thirdSubject.isEmpty || forthSubject.isEmpty || fifthSubject.isEmpty {
//                    errorMessage = "You have to enter 5 subjesct."
//                    return
//                }
//                print("List of all favorite subjects: ")
//                let subjectOne: Subject = Subject(title: firstSubject, subjectDescription: "This is a subject")
//                modelContext.insert(subjectOne)
//            }, label: {
//                Text("Finish setup")
//            })
//            Spacer()
//            Text(errorMessage).foregroundColor(.red)
//        }
//        
//    }
//}
//
//func isNameValid(name: String) -> Bool {
//    if !name.isEmpty && name.count > 2 {
//        return true
//    }
//    return false
//}
//
//#Preview {
//    ContentView()
//}
