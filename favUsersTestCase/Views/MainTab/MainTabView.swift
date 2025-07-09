//
//  MainTabView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: - Properties
    @EnvironmentObject var viewModel: MainTabViewModel
    @StateObject private var favoritesViewModel = FavoriteUsersViewModel()

    // MARK: - Body
    var body: some View {
        TabView {
            // MARK: - Users Tab
            UserListView()
                .tabItem { Label("Users", systemImage: "person.3") }

            // MARK: - Favorites Tab
            FavoritesView(viewModel: favoritesViewModel)
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
        }
        .loadingOverlay(viewModel.isLoading)
        .errorAlert($viewModel.errorMessage)
    }
}
