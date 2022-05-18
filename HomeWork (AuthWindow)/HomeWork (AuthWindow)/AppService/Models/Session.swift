//
//  Singleton.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 14.04.2022.
//

import Foundation

class Session {
    
    static var data = Session()
    
    private init(){}
    
    var token: String = ""
    var id: Int = 0
}

