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

struct User: Nameble, Equatable {
    
    static func == (lhs: User, rhs: User) -> Bool {
       return lhs.id == rhs.id
    }
    
    var id: Int
    var name: String
    var surname: String
    var avatar: UIImage?
    var fotoAlbum: [Foto]?
}
