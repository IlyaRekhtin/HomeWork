//
//  Photo.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 19.04.2022.
//

import Foundation

// MARK: - Photos
struct Photos: Codable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
    case photos = "response"
    }
}
