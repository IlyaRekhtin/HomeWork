//
//  Video.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation

struct Video: Codable {
    let accessKey: String
    let canComment, canLike, canRepost, canSubscribe: Int
    let canAddToFaves, canAdd: Int
    let comments: Int?
    let date: Int
    let videoDescription: String
    let duration: Int
    let image: [Size]
    let id, ownerID: Int
    let title: String
    let isFavorite: Bool
    let trackCode: String
    let type: AttachmentType?
    let views: Int
    let localViews: Int?
    let platform: VideoPlatform?
    let firstFrame: [Size]?
    let width, height: Int?
    let ovID, liveStatus: String?
    let videoRepeat: Int?

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type, views
        case localViews = "local_views"
        case platform
        case firstFrame = "first_frame"
        case width, height
        case ovID = "ov_id"
        case liveStatus = "live_status"
        case videoRepeat = "repeat"
    }
}

enum VideoPlatform: String, Codable {
    case youTube = "YouTube"
}
