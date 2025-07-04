//
//  FavoriteUser.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation
import SwiftData

@Model
final class FavoriteUser: Identifiable {
    @Attribute(.unique) var id: String
    var fullName: String
    var email: String
    var age: Int
    var phone: String
    var location: String
    var profileImageURL: String
    var gender: String
    var nationality: String

    init(from user: User) {
        self.id = user.id
        self.fullName = user.fullName
        self.email = user.email
        self.age = user.age
        self.phone = user.phone
        self.location = user.location
        self.profileImageURL = user.profileImageURL
        self.gender = user.gender
        self.nationality = user.nationality
    }
}
