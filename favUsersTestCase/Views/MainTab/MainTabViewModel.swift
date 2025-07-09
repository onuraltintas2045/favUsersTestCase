//
//  MainTabViewModel.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 4.07.2025.
//

import SwiftUI

@MainActor
class MainTabViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var users: [User] = []
    @Published var favoriteUsers: [FavoriteUser] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Dependencies
    private let repository: UserRepository

    // MARK: - Initialization
    init(repository: UserRepository) {
        self.repository = repository
        loadFavorites()
    }

    // MARK: - User Fetching
    func fetchUsers() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        NetworkManager.shared.fetchUsers(count: 30, countryCodes: ["us", "gb", "ca"]) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let fetchedUsers):
                    self.users = fetchedUsers
                case .failure(let error):
                    self.errorMessage = "Failed to fetch users: \(error.localizedDescription)"
                }
            }
        }
    }

    func fetchUsersIfNeeded() {
        if self.users.isEmpty {
            fetchUsers()
        }
    }

    // MARK: - Favorites Management
    func toggleFavorite(_ user: User) {
        isLoading = true
        errorMessage = nil

        do {
            if try repository.isFavoriteUser(user) {
                try repository.removeFromFavorites(user)
            } else {
                try repository.addToFavorites(user)
            }
            loadFavorites()
        } catch {
            self.errorMessage = "Toggle favorite error: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func loadFavorites() {
        do {
            self.favoriteUsers = try repository.fetchFavorites()
        } catch {
            self.errorMessage = "Load favorites error: \(error.localizedDescription)"
        }
    }

    func isFavoriteUser(_ user: User) -> Bool {
        (try? repository.isFavoriteUser(user)) ?? false
    }

    func filteredUsers(searchText: String) -> [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter {
                $0.fullName.localizedCaseInsensitiveContains(searchText) ||
                $0.email.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func removeUsersFromFavorites(userIDs: Set<String>) {
        for id in userIDs {
            if let user = favoriteUsers.first(where: { $0.id == id }) {
                toggleFavorite(user.toUser())
            }
        }
        loadFavorites()
    }

    // MARK: - Search Helpers
    func filteredFavoriteUsers(searchText: String) -> [User] {
        let favUsers = favoriteUsers.map { fav in
            User(
                id: fav.id,
                fullName: fav.fullName,
                email: fav.email,
                age: fav.age,
                phone: fav.phone,
                location: fav.location,
                profileImageURL: fav.profileImageURL,
                gender: fav.gender,
                nationality: fav.nationality
            )
        }

        if searchText.isEmpty {
            return favUsers
        } else {
            return favUsers.filter {
                $0.fullName.localizedCaseInsensitiveContains(searchText) ||
                $0.email.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
