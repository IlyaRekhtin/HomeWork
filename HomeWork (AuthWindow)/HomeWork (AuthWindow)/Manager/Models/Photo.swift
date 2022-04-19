//
//  Photo.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 19.04.2022.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id, ownerID: Int
    let photoCopyesOfDifSize: [Size]
    let description: String
    let likes: Likes
    let reposts: Reposts

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case photoCopyesOfDifSize = "sizes"
        case description = "text"
        case likes, reposts
    }
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: DifSizeOfPhoto
    let width: Int
}

enum DifSizeOfPhoto: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case x = "x"
    case y = "y"
    case z = "z"
}
