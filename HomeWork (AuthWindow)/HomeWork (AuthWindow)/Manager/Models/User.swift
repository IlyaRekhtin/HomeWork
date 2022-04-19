

import Foundation

// MARK: - User
struct User: Decodable {
    let id: Int
    let avatar: Avatar?
    let firstName, lastName: String
    let isClosed: Bool
    let city: City?
    let counters: Counters?

    enum CodingKeys: String, CodingKey {
        case id
        case avatar = "crop_photo"
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case city, counters
    }
}

// MARK: - City
struct City: Decodable {
    let id: Int
    let title: String
}

struct Counters: Decodable {
    let friends: Int
    let photos: Int
    let groups: Int
}

struct Avatar: Decodable {
    let photo: Photo
}
