//
//  SectionFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 26.08.2022.
//

import Foundation

class SectionFactory {
    ///  Определяем количество и тип строк исходя из содержимого News
    /// - Parameter news: cвойство с типом NewsItem
    /// - Returns: массив типов ячеек в соответствии с перечислением
    func sectionConstruct(for news: NewsItem) -> [CellType] {
        //возврощвемый массив
        var section = [CellType]()
        // первая строка всегда hendler(аватар и название источника новости)
        section.append(.header)
        // проверяем тип новости
        // в новости есть текст?
        if news.text != "" {
            section.append(.text) // добавляем строку если да
        }
        /// итд
        if news.photos?.count != 0 {
            section.append(.photos)
        }
        if news.videos?.count != 0 {
            section.append(.video)
        }
        if news.docs?.count != 0 {
            section.append(.docs)
        }
        if news.link != nil {
            section.append(.link)
        }
        section.append(.footer)
        return section
    }
}
