//
//  Friend.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation
import RealmSwift

class Friend: Object, Codable {
    @Persisted var id: Int
    @Persisted var city: City?
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var isClosed: Bool?
    @Persisted var photo50: String
    
    override class func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case city
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case photo50 = "photo_50"
    }
}
