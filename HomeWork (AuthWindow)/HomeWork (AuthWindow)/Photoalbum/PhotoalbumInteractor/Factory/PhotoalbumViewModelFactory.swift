//
//  PhotoalbumViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import Foundation

final class PhotoalbumViewModelFactory {
    
    func constructViewModel(for photos: [Photo]) -> [PhotoalbumViewModel] {
        return photos.compactMap(self.photoAlbumViewModel(for:))
    }
    
    private func photoAlbumViewModel(for photo: Photo) -> PhotoalbumViewModel {
        let likes: Int = photo.likes?.count ?? 0
        let isLiked: Bool = photo.likes?.userLikes == 1 ? true : false
        let reposts: Int = photo.reposts?.count ?? 0
        let isReposted: Bool = photo.reposts?.userReposted == 1 ? true : false
        let sourceID: Int = photo.ownerID
        let id: Int = photo.id
        let photo = getPhotoUrl(photo.sizes)
        return PhotoalbumViewModel(likes, isLiked, reposts, isReposted, sourceID, id, photo)
    }
    
    private func getPhotoUrl(_ sizes: [Size]) -> String {
        sizes.filter({$0.type?.rawValue == "x"}).first?.url ?? ""
    }
}
