//
//  NewsItemForProfile.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.07.2022.
//

import Foundation


struct NewsItemForProfile: NewsItemProtocol {
    
    var id: Int
    var profile: Profile
    var item: News
    
    init (news: News, profile: Profile) {
        self.id = news.sourceID
        self.item = news
        self.profile = profile
    }
    
}

extension NewsItemForProfile: Hashable {
    static func == (lhs: NewsItemForProfile, rhs: NewsItemForProfile) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
