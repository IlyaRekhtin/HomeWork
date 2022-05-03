//
//  Groups.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.04.2022.
//

import Foundation

// MARK: - Groups
struct Groups: Codable {
    let response: ResponseGroups
}

// MARK: - Response
struct ResponseGroups: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String
    let itemDescription: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
        case itemDescription = "description"
    }
}
