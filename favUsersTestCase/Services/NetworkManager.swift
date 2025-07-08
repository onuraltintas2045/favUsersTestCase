//
//  NetworkManager.swift
//  favUsersTestCase
//
//  Created by Onur Altintas on 3.07.2025.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    /// RandomUser API’den kullanıcıları çek
    /// - Parameters:
    ///   - results: Kaç adet kayıt çekilecek (default: 2)
    ///   - nationalities: Ülke kodları (default: ["us","gb","ca"])
    ///   - completion: Başarıda [User], başarısızlıkta Error döner
    func fetchUsers(results: Int, nationalities: [String], completion: @escaping (Result<[User], Error>) -> Void) {
        let natParam = nationalities.joined(separator: ",")
        guard let url = URL(string: "https://randomuser.me/api/?results=\(results)&nat=\(natParam)") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.zeroByteResource)))
                return
            }
            
            do {
                let root = try JSONDecoder().decode(User.RootResponse.self, from: data)
                let users = root.results.map { raw in
                    User(
                        id: raw.login.uuid,
                        fullName: "\(raw.name.first) \(raw.name.last)",
                        email: raw.email,
                        age: raw.dob.age,
                        phone: raw.phone,
                        location: "\(raw.location.city), \(raw.location.state), \(raw.location.country)",
                        profileImageURL: raw.picture.medium,
                        gender: raw.gender,
                        nationality: raw.nat
                    )
                }
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
