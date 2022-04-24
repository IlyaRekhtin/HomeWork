





import Foundation

// MARK: - Photos
struct Photos: Codable {
    let response: ResponsePhoto
}

// MARK: - Response
struct ResponsePhoto: Codable {
    let count: Int
    let items: [Photo]
}

// MARK: - Item
struct Photo: Codable, Hashable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let albumID, date, id, ownerID: Int
    let sizes: [Size]
    let text: String
    let hasTags: Bool
    let likes: Likes
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
struct Likes: Codable {
    let count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: String
    let width: Int
}
