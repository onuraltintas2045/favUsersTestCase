//
//  UserRepository.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation
import SwiftData

class UserRepository: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var favoriteUsers: [User] = []
    
    private let modelContext: ModelContext
    
    init(context: ModelContext) {
        self.modelContext = context
    }
    
    func fetchUsers() async {
        guard let url = URL(string: "https://example.com/api/users") else { return }
        do {
          let (data, _) = try await URLSession.shared.data(from: url)
          let decoded = try JSONDecoder().decode([User].self, from: data)
          let favIDs = Set(favoriteUsers.map(\.id))
          let mapped = decoded.map { user -> User in
            var u = user
            u.isFavorite = favIDs.contains(user.id)
            return u
          }
          await MainActor.run { self.users = mapped }
        } catch {
          print("API error:", error)
        }
    }
    
    func toggleFavorite(user: User) {
        if user.isFavorite {
            deleteFavorite(user: user)
        } else {
            addFavorite(user: user)
        }
    }
    
    private func addFavorite(user: User) {
        let favModel = FavoriteUser(from: user)
        modelContext.insert(favModel)

        do {
            try modelContext.save()
            // Save başarılıysa state'i güncelle
            DispatchQueue.main.async {
                var u = user
                u.isFavorite = true
                self.favoriteUsers.append(u)
                self.users = self.users.map { $0.id == u.id ? u : $0 }
            }
        } catch {
            print("SwiftData save error in addFavorite:", error)
        }
    }
    
    private func deleteFavorite(user: User) {
        // 1) Predicate ile ilgili FavoriteUser’ı çek
        let desc = FetchDescriptor<FavoriteUser>(
            predicate: #Predicate { $0.id == user.id }
        )

        do {
            let results = try modelContext.fetch(desc)
            guard let favModel = results.first else { return }

            // 2) Sil ve kaydet
            modelContext.delete(favModel)
            try modelContext.save()

            // 3) Local state güncelle
            DispatchQueue.main.async {
                self.favoriteUsers.removeAll { $0.id == user.id }
                self.users = self.users.map { u in
                    var u2 = u
                    if u2.id == user.id { u2.isFavorite = false }
                    return u2
                }
            }
        } catch {
            print("SwiftData delete error in deleteFavorite:", error)
        }
    }
    
    private func loadFavorites() {
            do {
                let favModels = try modelContext.fetch(FetchDescriptor<FavoriteUser>())
                let favs = favModels.map { fav -> User in
                    var u = User(
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
                    u.isFavorite = true
                    return u
                }

                DispatchQueue.main.async {
                    self.favoriteUsers = favs
                    let favIDs = Set(favs.map(\.id))
                    self.users = self.users.map {
                        var u = $0
                        u.isFavorite = favIDs.contains(u.id)
                        return u
                    }
                }
            } catch {
                print("SwiftData fetch error in loadFavorites:", error)
            }
        }
}
