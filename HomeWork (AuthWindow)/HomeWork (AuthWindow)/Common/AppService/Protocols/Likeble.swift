//
//  Likeble.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 05.05.2022.
//

import UIKit

protocol Likeble {
    var sourceID: Int {get set}
    var id: Int {get set}
    var likes: Int {get set}
    var isLiked: Bool {get set}
}
