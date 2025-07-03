//
//  UserListViewModel.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    private let repo: UserRepository
    
    init(repo: UserRepository) {
        self.repo = repo
        self.users = repo.users
    }
}
