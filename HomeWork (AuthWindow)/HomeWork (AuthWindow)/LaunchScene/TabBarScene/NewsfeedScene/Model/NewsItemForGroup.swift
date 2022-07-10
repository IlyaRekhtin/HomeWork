//
//  NewsItem.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 09.07.2022.
//

import Foundation

struct NewsItem {
    
    var id: Int
    var group: Group
    var item: News
    
    init (news: News, group: Group) {
        self.id = news.postID
        self.item = news
        self.group = group
        
        
    }
    
}

extension NewsItem: Hashable {
    static func == (lhs: NewsItem, rhs: NewsItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
