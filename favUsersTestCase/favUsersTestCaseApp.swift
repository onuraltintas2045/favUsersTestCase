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
    
    
    @StateObject private var repo: UserRepository

    init() {
        // .modelContainer değil, buradan context çekemeyeceğiniz için
        // fallback olarak ModelContainer’ı manuel kurup repo’yu başlatmanız gerekir.
        let container = try! ModelContainer(for: FavoriteUser.self)
        _repo = StateObject(wrappedValue: UserRepository(context: container.mainContext))
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(repo)
        }
        .modelContainer(for: FavoriteUser.self)
    }
}
