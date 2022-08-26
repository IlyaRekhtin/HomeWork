//
//  PhotoViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 25.08.2022.
//

import Foundation

class PhotoViewModelFactory {
    func constructViewModel(for attachment: [Attachment]?) -> [PhotoViewModel] {
        let photos = self.sortAttachmentForPhotos(attachment)
        return photos.compactMap(self.photoViewModel(for:))
    }
    
    func constructViewModel(for photos: [Photo]) -> [PhotoViewModel] {
        return photos.compactMap(self.photoViewModel(for:))
    }
    
    
    private func photoViewModel(for photo: Photo) -> PhotoViewModel {
        let urlStr = Photo.max(in: Array(photo.sizes))
        return PhotoViewModel(photo: urlStr)
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
