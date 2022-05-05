//
//  Newsfeed.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.04.2022.
//
import Foundation

// MARK: - Newsfeed
struct Newsfeed: Codable {
    let response: ResponseNewsfeed

}
// MARK: - Response
struct ResponseNewsfeed: Codable {
    let items: [News]
    let profiles: [User]
    let groups: [Group]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, profiles
        case groups
        case nextFrom = "next_from"
    }
}
// MARK: - ResponseItem
struct News: Codable, Likeble {
   
    let sourceID: Int
    let date: Int
    let text: String?
    let attachments: [Attachment]?
    var likes: Likes?
    let views: Views?
    let type: PostTypeEnum
    let carouselOffset: Int?
    let photos: ResponsePhoto?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case attachments
        case likes
        case views
        case type
        case carouselOffset = "carousel_offset"
        case photos
    }
}

enum PostTypeEnum: String, Codable {
    case post = "post"
    case photo = "photo"
    case wallPhoto = "wall_photo"
}
// MARK: - Attachment
struct Attachment: Codable {
    let type: AttachmentType
    let link: Link?
    let photo: Photo?
}

enum AttachmentType: String, Codable {
    case link = "link"
    case photo = "photo"
}

// MARK: - Link
struct Link: Codable {
    let url: String
    let title: String
    let caption: String
//    let linkDescription: String
    let photo: Photo
    let isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case url, title, caption
//        case linkDescription = "description"
        case photo
        case isFavorite = "is_favorite"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

