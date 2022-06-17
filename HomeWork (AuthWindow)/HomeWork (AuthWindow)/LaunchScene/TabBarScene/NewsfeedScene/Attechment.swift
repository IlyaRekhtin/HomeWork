//
//  Attechment.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation

// MARK: - ItemAttachment
struct Attachment: Codable {
    let type: AttachmentType?
    let link: Link?
    let photo: Photo?
    let audio: Audio?
    let video: Video?
    let doc: Doc?
    let poll: Poll?
}

enum AttachmentType: String, Codable {
    case audio = "audio"
    case doc = "doc"
    case link = "link"
    case photo = "photo"
    case video = "video"
    case poll = "poll"
    case live = "live"
}

// MARK: - Poll
struct Poll: Codable {
    let multiple: Bool
    let endDate: Int
    let closed, isBoard, canEdit, canVote: Bool
    let canReport, canShare: Bool
    let created, id, ownerID: Int
    let question: String
    let votes: Int
    let disableUnvote, anonymous: Bool
    let embedHash: String
    let photo: PollPhoto?
    let answers: [Answer]
    let authorID: Int

    enum CodingKeys: String, CodingKey {
        case multiple
        case endDate = "end_date"
        case closed
        case isBoard = "is_board"
        case canEdit = "can_edit"
        case canVote = "can_vote"
        case canReport = "can_report"
        case canShare = "can_share"
        case created, id
        case ownerID = "owner_id"
        case question, votes
        case disableUnvote = "disable_unvote"
        case anonymous
        case embedHash = "embed_hash"
        case photo, answers
        case authorID = "author_id"
    }
}

// MARK: - Answer
struct Answer: Codable {
    let id: Int
    let rate: Double
    let text: String
    let votes: Int
}

// MARK: - PollPhoto
struct PollPhoto: Codable {
    let color: String
    let id: Int
    let images: [Size]
}
