//
//  Photo.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation
import RealmSwift

class Photo:Object, Codable, Likeble {
    
//    struct LinkPhoto: Codable {
//        let albumID, date, id, ownerID: Int
//        let sizes: [VideoElement]
//        let text: String
//        let userID: Int
//        let hasTags: Bool
//        let accessKey: String?
//        let postID: Int?
//
//        enum CodingKeys: String, CodingKey {
//            case albumID = "album_id"
//            case date, id
//            case ownerID = "owner_id"
//            case sizes, text
//            case userID = "user_id"
//            case hasTags = "has_tags"
//            case accessKey = "access_key"
//            case postID = "post_id"
//        }
//    }
    @Persisted var albumID: Int
    @Persisted var date: Int
    @Persisted var id: Int
    @Persisted var ownerID: Int
    @Persisted var text: String
    @Persisted var hasTags: Bool
    @Persisted var likes: Likes?
    @Persisted var reposts: Reposts?
    @Persisted var sizes = List<Size>()
    
    override class func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case hasTags = "has_tags"
        case likes, reposts
    }
    
    static func getPhotoUrl(with size: TypeEnum, for photos: [Photo] ) -> [URL] {
        var urlsPhotosWithSize = [URL]()
        for photo in photos {
            for photoSize in photo.sizes {
                if photoSize.type!.rawValue  == size.rawValue {
                    guard let url = URL(string: photoSize.url) else {continue}
                    urlsPhotosWithSize.append(url)
                }
            }
        }
        return urlsPhotosWithSize
    }
}

