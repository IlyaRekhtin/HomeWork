//
//  SectionFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 26.08.2022.
//

import Foundation

class SectionFactory {
    ///  Определяем количество и тип строк исходя из содержимого News
    /// - Parameter news: cвойство с типом News
    /// - Returns: массив типов ячеек в соответствии с перечислением
    func sectionConstruct(for news: News) -> [CellType] {
        
        //возврощвемый массив
        var section = [CellType]()
        // первая строка всегда hendler(аватар и название источника новости)
        section.append(.header)
        // проверяем тип новости
        switch news.type {
        case .photo:
            // в новости есть текст?
            if news.text != nil, news.text != "" {
                section.append(.text) // добавляем строку если да
            }
            // в новости есть фотографии
            if news.photos != nil {
                section.append(.photos)// добавляем строку если да
            }
        case .post:
            // проверяем что массив с вложениями не пуст
            if let attachments = news.attachments {
                // фильтруем в соответствии с каждым типом вложения
                let link = attachments.filter{$0.type == .link}
                let photos = attachments.filter{$0.type == .photo}
                let audio = attachments.filter{$0.type == .audio}
                let video = attachments.filter{$0.type == .video}
                let docs = attachments.filter{$0.type == .doc}
                let poll = attachments.filter{$0.type == .poll}
                
                // в наличии значит добавляем
                if news.text != nil, news.text != "" {
                    section.append(.text)
                }
                if link.count != 0 {
                    section.append(.link)
                }
                if photos.count != 0 {
                    section.append(.photos)
                }
                if video.count != 0 {
                    section.append(.video)
                }
                if audio.count != 0 {
                    section.append(.audio)
                }
                if docs.count != 0 {
                    section.append(.docs)
                }
                if poll.count != 0 {
                    section.append(.poll)
                }
                section.append(.footer)
            }
        case .none:
            section.append(.footer)
        }
        return section
    }
}
