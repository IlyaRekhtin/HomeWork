//
//  User.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.04.2022.
//
import Foundation

// MARK: - Users response
struct Users: Decodable {
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
    case users = "response"
    }
}


