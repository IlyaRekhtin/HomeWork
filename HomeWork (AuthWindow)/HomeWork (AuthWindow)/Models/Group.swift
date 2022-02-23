//
//  Group.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.02.2022.
//

import Foundation
import UIKit

struct Group: Nameble, Equatable, Hashable {
    
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var name: String
    var avatar: UIImage?
}
