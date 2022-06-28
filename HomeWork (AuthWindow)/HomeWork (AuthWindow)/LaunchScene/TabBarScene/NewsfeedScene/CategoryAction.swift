//
//  CategoryAction.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation

struct CategoryAction: Codable {
    let action: Action?
    let name: String?
}

// MARK: - Action
struct Action: Codable {
    let target: String?
    let type: String?
    let url: String?
}
