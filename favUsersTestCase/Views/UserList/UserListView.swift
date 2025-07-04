//
//  UserListView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: MainTabViewModel
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            List(viewModel.filteredUsers(searchText: searchText)) { user in
                NavigationLink {
                    UserDetailView(user: user, viewModel: viewModel)
                } label: {
                    UserCardView(user: user, viewModel: viewModel)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.large) // Büyük başlık
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search by name or email")
            .refreshable {
                viewModel.fetchUsers()
            }
            .onAppear {
                if viewModel.users.isEmpty {
                    viewModel.fetchUsers()
                }
            }
        }
    }
}
