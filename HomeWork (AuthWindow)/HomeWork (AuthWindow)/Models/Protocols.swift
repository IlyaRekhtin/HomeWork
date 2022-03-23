//
//  Protocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 21.03.2022.
//

import UIKit

protocol User: Equatable {
    var id: Int {get}
    var name: String {get set}
    var description: String {get set}
    var avatar: UIImage {get set}
    var fotoAlbum: [Foto] {get set}
    
    func getFirstNameLetter() -> Character
    func getFirstSecondNameLetter() -> Character
}

extension Person {
    
    func getFirstNameLetter() -> Character {
        let letter = self.name.first!
        return letter
    }
    
    func getFirstSecondNameLetter() -> Character {
        let letter = self.description.first!
        return letter
    }
}

protocol Likeble: Hashable {
    var myLike: Bool {get set}
    var likesCount: Int {get set}
    
   mutating func addLikes()
   mutating func deleteLikes()
}

extension Likeble {
    
    mutating func addLikes() {
        likesCount += 1
        myLike = true
    }
    
    mutating func deleteLikes() {
        likesCount -= 1
        myLike = false
    }
}


