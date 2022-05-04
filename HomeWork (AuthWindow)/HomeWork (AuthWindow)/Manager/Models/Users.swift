//
//  User.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.04.2022.
//
import Foundation

// MARK: - Users response
struct Users: Codable {
    let users: ResponseUsers
    
    enum CodingKeys: String, CodingKey {
    case users = "response"
    }
}

// MARK: - Response
struct ResponseUsers: Codable {
    let count: Int
    let items: [User]
}


// MARK: - User
struct User: Codable {
    let id: Int
    let photo50: String
    let firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo50 = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
