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

class NewsItem: NSObject {
    var sourceID: Int
    var id: Int
    let header: HeaderViewModel?
    let date: Int
    let text: String
    var likes: Int
    @objc dynamic var isLiked: Bool
    let views: Int
    var reposts: Int
    var isReposted: Bool
    let link: LinkViewModel?
    let photos: [PhotoViewModel]?
    let videos: [VideoViewModel]?
    let docs: [DocViewModel]?
    
    init(sourceID: Int, id: Int, header: HeaderViewModel?, date: Int, text: String, likes: Int, isLiked: Bool, views: Int, reposts: Int, isReposted: Bool, link: LinkViewModel?, photos: [PhotoViewModel]?, videos: [VideoViewModel]?, docs: [DocViewModel]?) {
        self.sourceID = sourceID
        self.id = id
        self.header = header
        self.date = date
        self.text = text
        self.likes = likes
        self.isLiked = isLiked
        self.views = views
        self.reposts = reposts
        self.isReposted = isReposted
        self.link = link
        self.photos = photos
        self.videos = videos
        self.docs = docs
    }
}
