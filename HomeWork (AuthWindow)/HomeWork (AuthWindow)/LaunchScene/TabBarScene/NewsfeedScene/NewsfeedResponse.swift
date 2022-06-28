//
//  Newsfeed.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.04.2022.
//
import Foundation
import RealmSwift

// MARK: - Newsfeed
struct NewsfeedResponse: Codable {
   
    let newsfeed: Newsfeed
    
    enum CodingKeys: String, CodingKey {
    case newsfeed = "response"
    }

}
// MARK: - Response
struct Newsfeed: Codable {
    var items: [News]
    var profiles: [Profile]
    var groups: [Group]
    var nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
}
