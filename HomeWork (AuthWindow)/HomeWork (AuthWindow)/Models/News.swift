//
//  News.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.03.2022.
//

import UIKit

struct News: Likeble {
    
    var person: Person
    var newsText: String?
    var newsImages: [Foto]?
    var myLike: Bool
    var likesCount: Int
      
}
