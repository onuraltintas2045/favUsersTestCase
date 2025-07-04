//
//  favUsersTestCaseApp.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 2.07.2025.
//

import SwiftUI
import SwiftData

@main
struct favUsersTestCaseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FavoriteUser.self)
    }
}
