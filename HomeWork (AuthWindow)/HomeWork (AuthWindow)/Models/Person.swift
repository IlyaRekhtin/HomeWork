//
//  User.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.02.2022.
//

import Foundation
import UIKit


class Person: User1, Hashable {
    
    
    static func == (lhs: Person, rhs: Person) -> Bool {
       return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int
    var name: String
    var description: String = ""
    var avatar: UIImage = UIImage(named: "fotoIsEmpty")!
    var fotoAlbum: [Foto] = []
    
    init (id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init (id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    init (id: Int, name: String, description: String, avatar: UIImage){
        self.id = id
        self.name = name
        self.description = description
        self.avatar = avatar
    }
    
    init(id: Int, name: String, description: String, avatar: UIImage, album: [Foto]){
        self.id = id
        self.name = name
        self.description = description
        self.avatar = avatar
        self.fotoAlbum = album
    }
}
