//
//  Sizes.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation
import RealmSwift

class Size:Object, Codable, Comparable {
    static func < (lhs: Size, rhs: Size) -> Bool {
        lhs.width < rhs.width
    }
    
    @Persisted var height: Int = 0
    @Persisted var url: String = ""
    var type: TypeEnum?
    @Persisted var width: Int = 0
}
enum TypeEnum: String, Codable {
    case max = "max"
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
    case e = "e"
    case i = "i"
    case k = "k"
    case l = "l"
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
    case temp = "temp"
    
}
