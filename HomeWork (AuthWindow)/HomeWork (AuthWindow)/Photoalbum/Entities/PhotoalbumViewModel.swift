//
//  PhotoalbumViewModel.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import Foundation

class PhotoalbumViewModel: Hashable, Likeble, Reposteble {
    
    var likes: Int
    var isLiked: Bool
    var reposts: Int
    var isReposted: Bool
    var sourceID: Int
    var id: Int
    var photo: String
    
    init (_ likes: Int,
          _ isLiked: Bool,
          _ reposts: Int,
          _ isReposted: Bool,
          _ sourceID: Int,
          _ id: Int,
          _ photo: String) {
        self.likes = likes
        self.isLiked = isLiked
        self.reposts = reposts
        self.isReposted = isReposted
        self.sourceID = sourceID
        self.id = id
        self.photo = photo
    }
    
    static func == (lhs: PhotoalbumViewModel, rhs: PhotoalbumViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
