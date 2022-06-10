//
//  Photo.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation
import RealmSwift

class Photo:Object, Codable, Likeble {
    
    
   
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
    
    static func getURLForPhotos(_ photos: [Photo]) -> [URL]{
        var size = Size()
        var urls = [URL]()
        
        photos.forEach { photo in
            for currentSize in photo.sizes {
                if size < currentSize {
                    size = currentSize
                }
            }
            guard let url = URL(string: size.url) else {return}
            urls.append(url)
            size = Size()
        }
        return urls
    }
}

