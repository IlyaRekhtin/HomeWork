//
//  HeaderViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 25.08.2022.
//

import Foundation

class HeaderViewModelFactory {
    
    func constructViewModel(for news: News, for header: HeaderProtocol ) -> HeaderViewModel? {
        let avatar = header.avatar
        let fullName = header.name + (header.lastName ?? "")
        let date = getCurrentDate(for: news.date)
        let time = getCurrentTime(for: news.date)
        return HeaderViewModel(avatar: avatar, name: fullName, newsDate: date, newsTime: time)
    }
    
    private func getCurrentDate(for timeInterval: Int) -> String {
        let dateNews = Date(timeIntervalSince1970: Double(timeInterval))
        let dateFormatterForDate = DateFormatter()
        dateFormatterForDate.timeZone = .current
        dateFormatterForDate.locale = .current
        dateFormatterForDate.dateFormat = "dd-MM-yyy"
        let today = Calendar.current.startOfDay(for: .now)
        
        if Calendar.current.startOfDay(for: dateNews) == today {
             return "Сегодня"
        } else if Calendar.current.startOfDay(for: dateNews) == today - (60*60*24) {
            return "Вчера"
        } else {
            return dateFormatterForDate.string(from: dateNews)
        }
    }
    
    private func getCurrentTime(for timeInterval: Int) -> String {
        let dateNews = Date(timeIntervalSince1970: Double(timeInterval))
        let dateFormatterForTime = DateFormatter()
        dateFormatterForTime.timeZone = .current
        dateFormatterForTime.locale = .current
        dateFormatterForTime.dateFormat = "HH:mm"
        return dateFormatterForTime.string(from: dateNews)
    }
}
