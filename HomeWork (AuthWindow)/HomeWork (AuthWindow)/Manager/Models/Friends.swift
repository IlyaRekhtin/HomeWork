//
//  Friends.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 20.04.2022.
//

import Foundation

// MARK: - Friends
struct Friends: Codable {
    let response: ResponseFriends
}

// MARK: - Response
struct ResponseFriends: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let id: Int
    let city: City?
    let firstName, lastName: String
    let isClosed: Bool?
    let photo50: String
    let deactivated: Deactivated?

    enum CodingKeys: String, CodingKey {
        case id
        case city
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case photo50 = "photo_50"
        case deactivated
    }
}

enum Deactivated: String, Codable {
    case banned = "banned"
    case deleted = "deleted"
}

struct City: Codable {
    let title: String
}
