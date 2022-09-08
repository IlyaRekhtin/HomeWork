//
//  PhotoalbumViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import Foundation
import UIKit

class PhotoalbumViewModelFactory {
    
    var cachService: PhotoalbumCacheServiceProtocol = PhotoalbumCacheService()
    
    func constructViewModel(for items: [Photo]) -> [PhotoalbumViewModel]? {
        return items.compactMap(self.photoalbumViewModel(for:))
    }
    
    
    private func photoalbumViewModel(for item: Photo) -> PhotoalbumViewModel? {
        let likes = item.likes?.count ?? 0
        let isLiked = item.likes?.userLikes == 0 ? false : true
        let reposts = item.reposts?.count ?? 0
        let isReposted = item.reposts?.userReposted == 0 ? false : true
        let sourceID = item.ownerID
        let id = item.id
        let photo = getPhoto(getPhotoUrl(item.sizes))
        let ratio = ratio(for: item)
        return PhotoalbumViewModel(likes: likes, isLiked: isLiked, reposts: reposts, isReposted: isReposted, sourceID: sourceID, id: id, photo: photo, ratioPhoto: ratio)
    }
    
    private func ratio(for photo: Photo) -> CGFloat {
        guard let height = photo.height,
              let width = photo.width
        else {
            return 1
        }
        return CGFloat(height / width)
    }
    
    private func getPhoto(_ url: String) -> UIImage? {
        return self.cachService.getPhoto(by: url)
    }
    
    private func getPhotoUrl(_ sizes: [Size]) -> String {
        sizes.filter({$0.type?.rawValue == "x"}).first?.url ?? ""
    }
    

    
}
