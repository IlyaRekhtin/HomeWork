
import Foundation
import RealmSwift

// MARK: - Photos
struct Photos: Codable {
    var response: ResponsePhoto
}

// MARK: - Response
class ResponsePhoto:Object, Codable {
    @objc dynamic var count: Int = 0
    var items = List<Photo>()
}

// MARK: - Item
class Photo:Object, Codable, Likeble {
    
//    static func == (lhs: Photo, rhs: Photo) -> Bool {
//        lhs.id == rhs.id
//    }
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
    
    @objc dynamic var albumID, date, id, ownerID: Int
    @objc dynamic var text: String
    @objc dynamic var hasTags: Bool
    @objc dynamic var likes: Likes?
    @objc dynamic var reposts: Reposts
    var sizes = List<Size>()

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case hasTags = "has_tags"
        case likes, reposts
    }
}

// MARK: - Likes
class Likes:Object, Codable {
    @objc dynamic var count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
class Reposts:Object, Codable {
    @objc dynamic var count: Int
}

// MARK: - Size
class Size:Object, Codable {
    @objc dynamic var height: Int
    @objc dynamic var url: String
    @objc dynamic var type: String
    @objc dynamic var width: Int
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


