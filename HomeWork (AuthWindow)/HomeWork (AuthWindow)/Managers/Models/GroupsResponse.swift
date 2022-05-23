//
//  Groups.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.04.2022.
//

import Foundation
import RealmSwift

// MARK: - Groups
struct GroupsResponse: Codable {
    let groups: Groups
    
    enum CodingKeys: String, CodingKey {
    case groups = "response"
    }
}

// MARK: - Response
class Groups: Codable {
    var count: Int?
    var items: [Group]
}

// MARK: - Item
class Group:Object, Codable {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var screenName: String
    @Persisted var isClosed: Int
    @Persisted var type: String
    @Persisted var photo50: String
    @Persisted var itemDescription: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case photo50 = "photo_50"
        case itemDescription = "description"
    }
}
