//
//  MainTabView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var repo: UserRepository
    
    var body: some View {
    TabView {
      UserListView(viewModel: UserListViewModel(repo: repo))
        .tabItem { Label("Users", systemImage: "person.3") }

      FavoriteUsersView(viewModel: FavoriteUsersViewModel(repo: repo))
        .tabItem { Label("Favorites", systemImage: "heart.fill") }
    }
  }
}
