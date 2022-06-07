//
//  Profile.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation

struct Profile: Codable {
    let id, sex: Int
    let photo50, photo100: String
    let onlineInfo: OnlineInfo
    let online: Int
    let deactivated: String?
    let firstName, lastName: String
    let screenName: String?
    let onlineMobile, onlineApp: Int?
    let canAccessClosed, isClosed: Bool?

    enum CodingKeys: String, CodingKey {
        case id, sex
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online, deactivated
        case firstName = "first_name"
        case lastName = "last_name"
        case screenName = "screen_name"
        case onlineMobile = "online_mobile"
        case onlineApp = "online_app"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isOnline, isMobile: Bool
    let lastSeen, appID: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
        case appID = "app_id"
    }
}
