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
    
    let token: String = ""
    let id: Int = 0
}
