//
//  PhotoViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 25.08.2022.
//

import Foundation
import CloudKit

class PhotoViewModelFactory {
    func constructViewModel(for attachment: [Attachment]?) -> [PhotoViewModel]? {
        let photos = self.sortAttachmentForPhotos(attachment)
        return photos.compactMap(self.photoViewModel(for:))
    }
    
    func constructViewModel(for photos: [Photo]) -> [PhotoViewModel]? {
        return photos.compactMap(self.photoViewModel(for:))
    }
    
    
    private func photoViewModel(for photo: Photo) -> PhotoViewModel? {
        let likes = photo.likes?.count ?? 0
        let isLiked = photo.likes?.userLikes == 0 ? false : true
        let reposts = photo.reposts?.count ?? 0
        let isReposted = photo.reposts?.userReposted == 0 ? false : true
        let sourceID = photo.ownerID
        let id = photo.id
        let urlStr = Photo.max(in: Array(photo.sizes))
        return PhotoViewModel(likes: likes, isLiked: isLiked, reposts: reposts , isReposted: isReposted, sourceID: sourceID, id: id, photo: urlStr)
    }
    
    func sortAttachmentForPhotos(_ attachments: [Attachment]?) -> [Photo] {
        guard let attachments = attachments else {
            return []
        }
        var items = [Photo]()
        attachments.forEach { attachment in
            guard let photo = attachment.photo else {return}
            items.append(photo)
        }
        return items
    }
}
