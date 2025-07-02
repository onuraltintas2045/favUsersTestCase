//
//  User.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation

// MARK: - UI'da kullanılacak data modeli
struct User: Identifiable, Equatable {
    let id: String
    let fullName: String
    let email: String
    let age: Int
    let phone: String
    let location: String
    let profileImageURL: String
    let gender: String
    let nationality: String
}

// MARK: - API'den gelen ham JSON karşılığı
extension User {
    struct RawUser: Codable {
        let gender: String
        let name: Name
        let location: Location
        let email: String
        let dob: DOB
        let phone: String
        let picture: Picture
        let nat: String
        let login: Login

        struct Name: Codable {
            let first: String
            let last: String
        }

        struct Location: Codable {
            let city: String
            let state: String
            let country: String
        }

        struct DOB: Codable {
            let age: Int
        }

        struct Picture: Codable {
            let medium: String
        }

        struct Login: Codable {
            let uuid: String
        }
    }

    // MARK: - API root cevabı
    struct RootResponse: Codable {
        let results: [RawUser]
    }
}

