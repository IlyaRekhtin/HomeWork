
import Foundation

// MARK: - Photos
struct Photos: Codable {
    var response: ResponsePhoto
}

// MARK: - Response
struct ResponsePhoto: Codable {
    let count: Int
    var items: [Photo]
}

// MARK: - Item
struct Photo: Codable, Hashable, Likeble {
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
    
    let albumID, date, id, ownerID: Int
    let sizes: [Size]
    let text: String
    let hasTags: Bool
    var likes: Likes?
    let reposts: Reposts

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
struct Likes: Codable, Hashable {
    var count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts: Codable, Hashable {
    let count: Int
}

// MARK: - Size
struct Size: Codable, Hashable {
    let height: Int
    let url: String
    let type: String
    let width: Int
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


