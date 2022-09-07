//
//  Friends.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 20.04.2022.
//

import Foundation
import RealmSwift

// MARK: - Friends
struct FriendsResponse: Codable {
    let friends: Friends
    
    enum CodingKeys: String, CodingKey {
    case friends = "response"
    }
}

// MARK: - Response
struct Friends: Codable {
    var count: Int
    var items: [Friend]
}

