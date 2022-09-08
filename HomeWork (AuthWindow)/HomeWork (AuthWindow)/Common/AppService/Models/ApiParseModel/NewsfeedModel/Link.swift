//
//  Link.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation

// MARK: - Link
struct Link: Codable {
    static func == (lhs: Link, rhs: Link) -> Bool {
        lhs.url == rhs.url
    }
    
    let url: String
    let title: String?
    let caption: String?
    let linkDescription: String?
    let photo: Photo?
    let isFavorite: Bool?

    enum CodingKeys: String, CodingKey {
        case url, title, caption
        case linkDescription = "description"
        case photo
        case isFavorite = "is_favorite"
    }
}

