//
//  PhotoViewModel.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 25.08.2022.
//

import Foundation

struct PhotoViewModel: Hashable, Likeble, Reposteble {
    var likes: Int
    var isLiked: Bool
    var reposts: Int
    var isReposted: Bool
    var sourceID: Int
    var id: Int
    var photo: String
}
