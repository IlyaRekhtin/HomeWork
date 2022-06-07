
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

