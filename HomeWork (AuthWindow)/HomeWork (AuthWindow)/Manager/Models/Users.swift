//
//  User.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.04.2022.
//
import Foundation
import RealmSwift

// MARK: - Users response
struct Users: Codable {
    let users: ResponseUsers
    
    enum CodingKeys: String, CodingKey {
    case users = "response"
    }
}

// MARK: - Response
class ResponseUsers:Object, Codable {
    @Persisted var count: Int
    @Persisted var items = List<User>()
}


// MARK: - User
class User:Object, Codable {
    @Persisted var id: Int
    @Persisted var photo50: String
    @Persisted var firstName: String
    @Persisted var lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo50 = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
