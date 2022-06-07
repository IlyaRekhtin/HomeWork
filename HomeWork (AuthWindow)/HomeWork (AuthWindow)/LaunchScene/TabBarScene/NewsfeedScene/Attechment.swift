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
}

enum AttachmentType: String, Codable {
    case audio = "audio"
    case doc = "doc"
    case link = "link"
    case photo = "photo"
    case video = "video"
}
