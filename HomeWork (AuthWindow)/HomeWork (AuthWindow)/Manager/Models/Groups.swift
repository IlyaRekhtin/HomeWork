//
//  Groups.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.04.2022.
//

import Foundation
import RealmSwift

// MARK: - Groups
struct Groups: Codable {
    let response: ResponseGroups
}

// MARK: - Response
class ResponseGroups:Object, Codable {
    @objc dynamic var count: Int
    var items = List<Group>()
}

// MARK: - Item
class Group:Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name, screenName: String
    @objc dynamic var isClosed: Int
    @objc dynamic var type: String
    @objc dynamic var photo50: String
    @objc dynamic var itemDescription: String = ""

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case photo50 = "photo_50"
        case itemDescription = "description"
    }
}
