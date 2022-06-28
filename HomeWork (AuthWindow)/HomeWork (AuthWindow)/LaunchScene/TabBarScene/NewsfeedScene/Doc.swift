//
//  Doc.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation

struct Doc: Codable, Hashable {
    let id, ownerID: Int?
    let title: String?
    let size: Int?
    let ext: String?
    let date, type: Int?
    let url: String?
    let accessKey: String?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case title, size, ext, date, type, url
        case accessKey = "access_key"
    }
}
