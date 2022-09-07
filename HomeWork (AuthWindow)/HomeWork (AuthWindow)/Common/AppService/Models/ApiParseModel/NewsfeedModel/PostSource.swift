//
//  PostSource.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation

struct PostSource: Codable {
    let platform: PostSourcePlatform?
    let type: PostSourceType?
}

enum PostSourcePlatform: String, Codable {
    case iphone = "iphone"
}

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}
