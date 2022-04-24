//
//  User.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.04.2022.
//
import Foundation

// MARK: - Users response
struct Users: Codable {
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
    case users = "response"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let avatar: String
    let firstName, lastName: String
    let isClosed: Bool
    let city: City?
    let counters: Counters?

    enum CodingKeys: String, CodingKey {
        case id
        case avatar = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case city, counters
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}

struct Counters: Codable {
    let friends: Int
    let photos: Int
    let groups: Int
}

