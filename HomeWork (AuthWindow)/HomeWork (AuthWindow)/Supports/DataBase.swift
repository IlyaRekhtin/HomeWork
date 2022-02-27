//
//  DataBase.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 18.02.2022.
//

import Foundation
import UIKit

class DataBase {
    static let data = DataBase()
    
    var password: String = ""
    var login: String = ""
    
    
    var friends = [User(id: 1, name: "Илья", surname: "Иванов", avatar: UIImage(named: "ava1")), User(id: 2, name: "Анна", surname: "Пивоварова", avatar: UIImage(named: "ava2")), User(id: 3, name: "Евгений", surname: "Цветков", avatar: UIImage(named: "ava3")), User(id: 4, name: "Александр", surname: "Кроеведов", avatar: UIImage(named: "ava4"))]
    
    var allGroups: [Group] = [Group(id: 1, name: "Клуб любителей котиков", avatar: UIImage(named: "gpCat")), Group(id: 2, name: "Клуб любителй собак", avatar: UIImage(named: "gpDog")), Group(id: 3, name: "Клуб любителей коняшек", avatar: UIImage(named: "gpHourse"))]
    
    var myGroups: Set<Group> = [Group(id: 1, name: "Клуб любителей котиков", avatar: UIImage(named: "gpCat"))]
    
    
    var myFotoExemple = [Foto(UIImage(named: "exp1")!), Foto(UIImage(named: "exp2")!), Foto(UIImage(named: "exp3")!), Foto(UIImage(named: "exp4")!)]
    
    
    func getCurrentLogin () -> String {
        guard let currentLogin = UserDefaults.standard.object(forKey: "login") as? String else { return "" }
        return currentLogin
    }
    
    func getCurrentPassword() -> String {
        guard let currentPassword = UserDefaults.standard.object(forKey: "password") as? String else { return "" }
        return currentPassword
    }
}




