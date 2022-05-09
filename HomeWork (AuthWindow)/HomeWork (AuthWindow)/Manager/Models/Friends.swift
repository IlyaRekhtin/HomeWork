//
//  Friends.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 20.04.2022.
//

import Foundation
import RealmSwift

// MARK: - Friends
struct Friends: Codable {
    let response: ResponseFriends
}

// MARK: - Response
class ResponseFriends:Object, Codable {
    @objc dynamic var count: Int = 0
    var items = List<Friend>()
}

// MARK: - Item
class Friend:Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var city: City?
    @objc dynamic var firstName, lastName: String
    @objc dynamic var isClosed: Bool
    @objc dynamic var photo50: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case city
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case photo50 = "photo_50"
    }
}

class City:Object, Codable {
    @objc dynamic var title: String = ""
}
