//
//  User.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.04.2022.
//
import Foundation
import RealmSwift

// MARK: - Users response
struct UsersResponse: Codable {
    let users: Users
    
    enum CodingKeys: String, CodingKey {
    case users = "response"
    }
}

// MARK: - Response
struct Users: Codable {
    
    var count: Int
    var items: [User]
}


// MARK: - User
class User:Object, Codable {
    
    @Persisted var id: Int
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var isClosed: Bool
    @Persisted var photo50: String
    
    override class func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case photo50 = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
    }
}
