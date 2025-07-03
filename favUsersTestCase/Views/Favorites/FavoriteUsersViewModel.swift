//
//  FavoriteUsersViewModel.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation

class FavoriteUsersViewModel: ObservableObject {
    @Published var favoriteUsers: [User]
    private var repo: UserRepository
    
    init(repo: UserRepository) {
        self.repo = repo
        self.favoriteUsers = repo.favoriteUsers
    }
}
