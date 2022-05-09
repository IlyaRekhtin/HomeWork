//
//  Newsfeed.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.04.2022.
//
import Foundation
import RealmSwift

// MARK: - Newsfeed
struct Newsfeed: Codable {
    let response: ResponseNewsfeed

}
// MARK: - Response
class ResponseNewsfeed:Object, Codable {
    @Persisted var items: List<News>
    @Persisted var profiles: List<User>
    @Persisted var groups: List<Group>
    @Persisted var nextFrom: String = ""

    enum CodingKeys: String, CodingKey {
        case items, profiles
        case groups
        case nextFrom = "next_from"
    }
}
// MARK: - ResponseItem
class News:Object, Codable, Likeble {
   
    @Persisted var sourceID: Int
    @Persisted var date: Int
    @Persisted var text: String?
    @Persisted var likes: Likes?
    @Persisted var views: Views?
    @Persisted var type: String = ""
    @Persisted var carouselOffset: Int?
    @Persisted var photos: ResponsePhoto?
    var attachments: List<Attachment>?
    
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
class Attachment:Object, Codable {
    @Persisted var type: String
    @Persisted var link: Link?
    @Persisted var photo: Photo?
}

enum AttachmentType: String, Codable {
    case link = "link"
    case photo = "photo"
}

// MARK: - Link
class Link:Object, Codable {
    @Persisted var url: String
    @Persisted var title: String
    @Persisted var caption: String
//    let linkDescription: String
    @Persisted var photo: Photo
    @Persisted var isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case url, title, caption
//        case linkDescription = "description"
        case photo
        case isFavorite = "is_favorite"
    }
}

// MARK: - Views
class Views:Object, Codable {
    @Persisted var count: Int
}

