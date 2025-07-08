//
//  MainTabView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: MainTabViewModel
    @StateObject private var favoritesViewModel: FavoriteUsersViewModel

    init(viewModel: MainTabViewModel) {
        _favoritesViewModel = StateObject(wrappedValue: FavoriteUsersViewModel(mainViewModel: viewModel))
    }

    var body: some View {
        TabView {
            UserListView()
                .tabItem { Label("Users", systemImage: "person.3") }

            FavoritesView(viewModel: favoritesViewModel)
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
        }
        .loadingOverlay(viewModel.isLoading)
        .errorAlert($viewModel.errorMessage)
    }
}
