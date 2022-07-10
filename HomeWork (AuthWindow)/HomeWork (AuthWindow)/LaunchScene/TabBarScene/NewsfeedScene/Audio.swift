//
//  Audio.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation

// MARK: - Audio
struct Audio: Codable, Hashable {
    let artist: String?
    let id, ownerID: Int?
    let title: String?
    let duration: Int?
    let isExplicit, isFocusTrack: Bool?
    let trackCode: String?
    let url: String?
    let date, genreID: Int?
    let shortVideosAllowed, storiesAllowed, storiesCoverAllowed: Bool?

    enum CodingKeys: String, CodingKey {
        case artist, id
        case ownerID = "owner_id"
        case title, duration
        case isExplicit = "is_explicit"
        case isFocusTrack = "is_focus_track"
        case trackCode = "track_code"
        case url, date
        case genreID = "genre_id"
        case shortVideosAllowed = "short_videos_allowed"
        case storiesAllowed = "stories_allowed"
        case storiesCoverAllowed = "stories_cover_allowed"
    }
}
