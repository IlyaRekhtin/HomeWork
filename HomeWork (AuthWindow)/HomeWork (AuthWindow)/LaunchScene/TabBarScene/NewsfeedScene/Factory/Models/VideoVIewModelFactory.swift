//
//  VideoVIewModel.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 25.08.2022.
//

import Foundation

class VideoViewModelFactory {
    func constructViewModel(_ attachments: [Attachment]?) -> [VideoViewModel] {
        let videos = self.sortAttachmentForVideo(attachments)
        return videos.compactMap(self.videoViewModel(for:))
    }
    
    private func sortAttachmentForVideo(_ attachments: [Attachment]?) -> [Video] {
        guard let attachments = attachments else {
            return []
        }
        var items = [Video]()
        attachments.forEach { attachment in
            guard let video = attachment.video else {return}
            items.append(video)
        }
        return items
    }
    
    private func videoViewModel(for video: Video) -> VideoViewModel? {
        guard let image = video.image else {return nil}
        let urlStr = Photo.preview(in: image)
        guard let videoDuration = video.duration else {return nil}
        return VideoViewModel(image: urlStr, duration: videoDuration)
    }
}
