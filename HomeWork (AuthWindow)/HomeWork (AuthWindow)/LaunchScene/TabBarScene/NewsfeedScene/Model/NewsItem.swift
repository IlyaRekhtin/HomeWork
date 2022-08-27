//
//  NewsItem.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.08.2022.
//

import Foundation


struct NewsfeedItems {
    var newsItems = [NewsItem]()
    var nextForm = ""
}

struct NewsItem: Likeble, Reposteble {
    var sourceID: Int
    var id: Int
    let header: HeaderViewModel?
    let date: Int
    let text: String
    var likes: Int
    var isLiked: Bool
    let views: Int
    var reposts: Int
    var isReposted: Bool
    let link: LinkViewModel?
    let photos: [PhotoViewModel]?
    let videos: [VideoViewModel]?
    let docs: [DocViewModel]?
}
