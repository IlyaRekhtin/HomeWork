//
//  NewsfeedFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.08.2022.
//

import Foundation

class NewsfeedFactory {
    
    func constructNewsItem(from newsfeed: Newsfeed) -> NewsfeedItems? {
        var newsfeedItems = NewsfeedItems()
        newsfeedItems.newsItems = newsfeed.items.compactMap({ news in
            if news.sourceID < 0 {
                guard let group = newsfeed.groups.filter({-$0.id == news.sourceID}).first else {return nil}
                return self.createNewsItem(news, group)
            } else {
                guard let profile = newsfeed.profiles.filter({$0.id == news.sourceID}).first else {return nil}
                return self.createNewsItem(news, profile)
            }
        })
        newsfeedItems.nextForm = newsfeed.nextFrom ?? ""
        return newsfeedItems
    }
    
    private func createNewsItem(_ news: News, _ header: HeaderProtocol) -> NewsItem? {
        let sourceID = news.sourceID
        let postID = news.postID
        let profil = HeaderViewModelFactory().constructViewModel(for: news, for: header)
        let date = news.date
        let text = news.text ?? ""
        let likes = news.likes?.count ?? 0
        let isLiked = news.likes?.userLikes == 0 ? false : true
        let views = news.views?.count ?? 0
        let reposts = news.reposts?.count ?? 0
        let isReposted = news.reposts?.userReposted == 0 ? false : true
        let link = LinkViewModelFactory().constructViewModel(for: news.attachments)
        let photos = self.getPhotos(news)
        let videos = VideoViewModelFactory().constructViewModel(news.attachments)
        let docs = DocViewModelFactory().constructViewModel(news.attachments)
        return NewsItem(sourceID: sourceID, id: postID, header: profil, date: date, text: text, likes: likes, isLiked: isLiked, views: views, reposts: reposts, isReposted: isReposted, link: link, photos: photos, videos: videos, docs: docs)
    }
    
    private func getPhotos(_ news: News) -> [PhotoViewModel]? {
        if news.type == .post {
            return PhotoViewModelFactory().constructViewModel(for: news.attachments)
        } else {
            guard let photos = news.photos else {return nil}
            return PhotoViewModelFactory().constructViewModel(for: Array(photos.items))
        }
    }
}
