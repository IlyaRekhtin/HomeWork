
import Foundation

// MARK: - Photos
struct PhotosResponse: Codable {
    var photos: Photos
    
    enum CodingKeys: String, CodingKey {
    case photos = "response"
    }
}

// MARK: - Response
class Photos: Codable {
    var count: Int = 0
    var items = [Photo]()
}

