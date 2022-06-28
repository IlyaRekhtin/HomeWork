//
//  Groups.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.04.2022.
//

import Foundation
import RealmSwift

// MARK: - Groups
struct GroupsResponse: Codable {
    let groups: Groups
    
    enum CodingKeys: String, CodingKey {
    case groups = "response"
    }
}

// MARK: - Response
class Groups: Codable {
    var count: Int?
    var items: [Group]
}

// MARK: - Item

