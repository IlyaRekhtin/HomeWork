//
//  Photo.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import UIKit
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
    
    static func getURLForMaxPhotos(_ photos: [Photo]) -> [URL]{
        var size = Size()
        var urls = [URL]()
        photos.forEach { photo in
            for currentSize in photo.sizes {
                if size <= currentSize {
                    size = currentSize
                }
            }
            guard let url = URL(string: size.url) else {return}
            urls.append(url)
            size = Size()
        }
        return urls
    }
    
    static func ratio(for photo: Photo) -> CGFloat {
        let height = CGFloat(photo.sizes.last?.height ?? 1)
        let width = CGFloat(photo.sizes.last?.width ?? 1)
        return height / width
    }
    
    static func preview(in sizes: [Size]) -> String {
        var size = Size()
        for currentSize in sizes {
            if size <= currentSize, currentSize.width ?? 1 <= 300 {
                size = currentSize
            }
        }
        return size.url
    }
    
    
    static func max(in sizes: [Size]) -> String {
        var size = Size()
        for currentSize in sizes {
            if size <= currentSize {
                size = currentSize
            }
        }
        return size.url
    }
    
}

