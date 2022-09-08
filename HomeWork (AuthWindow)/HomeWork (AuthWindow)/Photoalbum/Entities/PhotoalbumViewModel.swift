//
//  PhotoalbumViewModel.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit

final class PhotoalbumViewModel: Hashable, Likeble, Reposteble {
    
    var likes: Int = 0
    var isLiked: Bool = false
    var reposts: Int = 0
    var isReposted: Bool = false
    var sourceID: Int = 0
    var id: Int = 0
    var photo: UIImage? = nil
    var ratioPhoto: CGFloat = 0.0
    
    init(likes: Int, isLiked: Bool, reposts: Int, isReposted: Bool, sourceID: Int, id: Int, photo: UIImage?, ratioPhoto: CGFloat) {
        self.likes = likes
        self.isLiked = isLiked
        self.reposts = reposts
        self.isReposted = isReposted
        self.sourceID = sourceID
        self.id = id
        self.photo = photo
        self.ratioPhoto = ratioPhoto
    }
    
    static func == (lhs: PhotoalbumViewModel, rhs: PhotoalbumViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
