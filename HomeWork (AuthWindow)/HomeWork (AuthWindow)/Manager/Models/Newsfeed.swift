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
    var items = List<News>()
    var profiles = List<User>()
    var groups = List<Group>()
    @objc dynamic var nextFrom: String = ""

    enum CodingKeys: String, CodingKey {
        case items, profiles
        case groups
        case nextFrom = "next_from"
    }
}
// MARK: - ResponseItem
class News:Object, Codable, Likeble {
   
    @objc dynamic var sourceID: Int
    @objc dynamic var date: Int
    @objc dynamic var text: String?
    var attachments: List<Attachment>?
    @objc dynamic var likes: Likes?
    @objc dynamic var views: Views?
    @objc dynamic var type: String = ""
    @objc dynamic var carouselOffset: Int
    @objc dynamic var photos: ResponsePhoto?

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
    @objc dynamic var type: String
    @objc dynamic var link: Link?
    @objc dynamic var photo: Photo?
}

enum AttachmentType: String, Codable {
    case link = "link"
    case photo = "photo"
}

// MARK: - Link
class Link:Object, Codable {
    @objc dynamic var url: String
    @objc dynamic var title: String
    @objc dynamic var caption: String
//    let linkDescription: String
    @objc dynamic var photo: Photo
    @objc dynamic var isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case url, title, caption
//        case linkDescription = "description"
        case photo
        case isFavorite = "is_favorite"
    }
}

// MARK: - Views
class Views:Object, Codable {
    @objc dynamic var count: Int
}

