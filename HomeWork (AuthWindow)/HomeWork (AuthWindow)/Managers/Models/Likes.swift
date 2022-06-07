//
//  Likes.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation
import RealmSwift

class Likes:Object, Codable {
    @Persisted var count: Int
    @Persisted var userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}
