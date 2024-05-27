//
//  Chapter_ChaserApp.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-02-28.
//

import SwiftUI
import SwiftData

@main
struct Chapter_ChaserApp: App {
    
//    var container: ModelContainer
//    init() {
//        do {
//            let bookConfiguration = ModelConfiguration(for: Book.self)
//            let subjectConfiguration = ModelConfiguration(for: Subject.self)
//            let userCOnfiguration = ModelConfiguration(for: User.self)
//            
//            container = try ModelContainer(for: Book.self, Subject.self, User.self, configurations: bookConfiguration, subjectConfiguration, userCOnfiguration)
//            
//        } catch {
//            fatalError("Failed to configure Swiftdata continer")
//        }
//   }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Book.self, User.self, Subject.self])
    }
}
