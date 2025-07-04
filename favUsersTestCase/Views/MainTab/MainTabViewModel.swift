//
//  MainTabViewModel.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 4.07.2025.
//

import Foundation
import SwiftUI

@MainActor
class MainTabViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var favoriteUsers: [FavoriteUser] = []

    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
        loadFavorites()
    }

    func fetchUsers() {
        NetworkManager.shared.fetchUsers(results: 15, nationalities: ["us", "gb", "ca"]) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedUsers):
                    self.users = fetchedUsers
                case .failure(let error):
                    print("NetworkManager error:", error)
                }
            }
        }
    }

    func toggleFavorite(_ user: User) {
        if repository.isFavorite(user) {
            repository.removeFavorite(user)
        } else {
            repository.addFavorite(user)
        }
        loadFavorites()
    }

    func isFavorite(_ user: User) -> Bool {
        repository.isFavorite(user)
    }

    func loadFavorites() {
        favoriteUsers = repository.fetchFavorites()
    }
}
