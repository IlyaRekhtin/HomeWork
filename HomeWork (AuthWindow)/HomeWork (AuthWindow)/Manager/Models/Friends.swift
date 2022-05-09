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
    @Persisted var count: Int = 0
    @Persisted var items = List<Friend>()
}

// MARK: - Item
class Friend:Object, Codable {
    @Persisted var id: Int
    @Persisted var city: City?
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var isClosed: Bool
    @Persisted var photo50: String

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
    @Persisted var title: String = ""
}
