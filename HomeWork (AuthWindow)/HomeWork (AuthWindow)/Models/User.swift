//
//  User.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.02.2022.
//

import Foundation
import UIKit
protocol Nameble {
    var id: Int {get}
    var name: String {get set}
}

class User: Nameble, Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
       return lhs.id == rhs.id
    }
    
    var id: Int
    var name: String
    var surname: String
    var avatar: UIImage = UIImage(systemName: "person")!
    var fotoAlbum: [Foto] = []
    
    init (id: Int, name: String, surname: String) {
        self.id = id
        self.name = name
        self.surname = surname
    }
    
    init (id: Int, name: String, surname: String, avatar: UIImage){
        self.id = id
        self.name = name
        self.surname = surname
        self.avatar = avatar
    }
    
    init(id: Int, name: String, surname: String, avatar: UIImage, album: [Foto]){
        self.id = id
        self.name = name
        self.surname = surname
        self.avatar = avatar
        self.fotoAlbum = album
    }
    
    
}
