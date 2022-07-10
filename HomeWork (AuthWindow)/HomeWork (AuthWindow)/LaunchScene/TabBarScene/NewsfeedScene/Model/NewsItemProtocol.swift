//
//  NewsItemProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.07.2022.
//

import Foundation

protocol NewsItemProtocol {
    var id: Int {get set}
    var item: News {get set}
}
