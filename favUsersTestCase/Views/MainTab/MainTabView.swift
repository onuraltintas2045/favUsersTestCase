//
//  MainTabView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: MainTabViewModel

    var body: some View {
        TabView {
            UserListView()
                .tabItem { Label("Users", systemImage: "person.3") }

            FavoritesView(viewModel: FavoriteUsersViewModel(mainViewModel: viewModel))
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
        }
        .loadingOverlay(viewModel.isLoading)
        .errorAlert($viewModel.errorMessage)
    }
}
