//
//  User.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.04.2022.
//
import Foundation

// MARK: - User
struct Users: Decodable {
    let users: [User]
    enum CodingKeys: String, CodingKey {
    case users = "response"
    }
}

// MARK: - Response
struct User: Decodable {
    let id: Int
    let firstName, lastName: String
    let isClosed: Bool
    let city: City
    let counters: Counters

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case city, counters
    }
}

// MARK: - City
struct City: Decodable {
    let id: Int
    let title: String
}

struct Counters: Decodable {
    let friends: Int
    let photos: Int
    let groups: Int
}
