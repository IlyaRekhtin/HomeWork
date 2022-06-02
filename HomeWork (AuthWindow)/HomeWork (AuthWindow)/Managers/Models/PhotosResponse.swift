
import Foundation
import RealmSwift

// MARK: - Photos
struct PhotosResponse: Codable {
    var photos: Photos
    
    enum CodingKeys: String, CodingKey {
    case photos = "response"
    }
}

// MARK: - Response
class Photos:Object, Codable {
    
    @Persisted var count: Int = 0
    @Persisted var items = List<Photo>()
}

// MARK: - Item
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
    
    static func getPhotoUrl(with size: TypeEnum, for photos: [Photo] ) -> [URL] {
        var urlsPhotosWithSize = [URL]()
        for photo in photos {
            for photoSize in photo.sizes {
                if photoSize.type  == size.rawValue {
                    guard let url = URL(string: photoSize.url) else {continue}
                    urlsPhotosWithSize.append(url)
                }
            }
        }
        return urlsPhotosWithSize
    }
}

// MARK: - Likes
class Likes:Object, Codable {
    @Persisted var count: Int
    @Persisted var userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
class Reposts:Object, Codable {
    @Persisted var count: Int
    @Persisted var userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Size
class Size:Object, Codable {
    @Persisted var height: Int = 0
    @Persisted var url: String = ""
    @Persisted var type: String = ""
    @Persisted var width: Int = 0
    
    
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case x = "x"
    case y = "y"
    case z = "z"
}


