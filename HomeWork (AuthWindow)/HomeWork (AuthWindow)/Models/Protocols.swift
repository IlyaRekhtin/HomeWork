//
//  Protocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 21.03.2022.
//

import UIKit


protocol Likeble: Hashable {
    var myLike: Bool {get set}
    var likes: Likes {get set}
    
   mutating func addLikes()
   mutating func deleteLikes()
}

extension Likeble {
    
    mutating func addLikes() {
//        likes.count += 1
        myLike = true
    }
    
    mutating func deleteLikes() {
//        likesCount -= 1
        myLike = false
    }
}


