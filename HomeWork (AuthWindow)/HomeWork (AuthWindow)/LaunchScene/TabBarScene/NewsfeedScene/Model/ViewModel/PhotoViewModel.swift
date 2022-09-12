//
//  PhotoViewModel.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 25.08.2022.
//

import Foundation

final class PhotoViewModel: Hashable, Likeble, Reposteble {
    
    var likes: Int
    var isLiked: Bool
    var reposts: Int
    var isReposted: Bool
    var sourceID: Int
    var id: Int
    var photo: String
    
    init( likes: Int, isLiked: Bool, reposts: Int, isReposted: Bool, sourceID: Int, id: Int, photo: String) {
        self.likes = likes
        self.isLiked = isLiked
        self.reposts = reposts
        self.isReposted = isReposted
        self.sourceID = sourceID
        self.id = id
        self.photo = photo
    }
    
    static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
