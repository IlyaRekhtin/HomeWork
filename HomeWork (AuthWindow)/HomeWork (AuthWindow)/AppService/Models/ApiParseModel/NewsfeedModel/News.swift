//
//  News.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation

struct News: Codable {
   
    let sourceID: Int
    let postID: Int
    let date: Int
    let text: String?
    let isFavorite: Bool?
    let postType: PostTypeEnum?
    var likes: Likes?
    var views: Views?
    var reposts: Reposts?
    let comments: Comments?
    let type: PostTypeEnum?
    let categoryAction: CategoryAction?
    let carouselOffset: Int?
    let attachments: [Attachment]?
    let photos: Photos? 
    
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case postID = "post_id"
        case date
        case isFavorite = "is_favorite"
        case postType = "post_type"
        case text
        case attachments
        case photos
        case comments, likes, reposts, views
        case type
        case carouselOffset = "carousel_offset"
        case categoryAction = "category_action"
    }
}

enum PostTypeEnum: String, Codable {
    case post = "post"
    case photo = "photo"
}
