//
//  UserListView.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: MainTabViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.users) { user in
                NavigationLink {
                    UserDetailView(user: user, viewModel: viewModel)
                } label: {
                    UserCardView(user: user, viewModel: viewModel)
                }
            }
            .navigationTitle("Users")
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}
