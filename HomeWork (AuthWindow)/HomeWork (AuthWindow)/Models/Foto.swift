//
//  File.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 27.02.2022.
//

import Foundation
import UIKit

struct Foto: Hashable, Equatable {
    
    var image: UIImage
    var myLike: Bool = false
    var likesCount: Int = 100000
    
    
    
    init(_ foto: UIImage) {
        self.image = foto
    }
    
    mutating func addLikes() {
        likesCount += 1
        myLike = true
    }
    
    mutating func deleteLikes() {
        likesCount -= 1
        myLike = false
    }
}
