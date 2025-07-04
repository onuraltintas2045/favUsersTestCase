//
//  MainTabView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var viewModel: MainTabViewModel

    var body: some View {
        TabView {
            UserListView(viewModel: viewModel)
                .tabItem { Label("Users", systemImage: "person.3") }

            FavoritesView(viewModel: viewModel)
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
        }
    }
}
