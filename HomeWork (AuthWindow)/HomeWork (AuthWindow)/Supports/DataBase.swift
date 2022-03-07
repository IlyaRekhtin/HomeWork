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
    
    
    var friends = [User(id: 1, name: "Илья", surname: "Иванов", avatar: UIImage(named: "ava1")!, album: [Foto(UIImage(named: "exp1")!), Foto(UIImage(named: "exp2")!)]),
                   User(id: 2, name: "Анна", surname: "Пивоварова", avatar: UIImage(named: "ava2")!),
                   User(id: 3, name: "Евгений", surname: "Цветков", avatar: UIImage(named: "ava3")!, album: [Foto(UIImage(named: "exp3")!)]),
                   User(id: 4, name: "Александр", surname: "Кроеведов", avatar: UIImage(named: "ava4")!),
                   User(id: 5, name: "Женя", surname: "Смолин", avatar: UIImage(named: "ava5")!),
                   User(id: 6, name: "Егор", surname: "Минеев"),
                   User(id: 7, name: "Geprgiy", surname: "PimenoFF"),
                   User(id: 8, name: "Serg", surname: "Korel"),
                   User(id: 9, name: "Максим", surname: "Усенко"),
                   User(id: 10, name: "Станислав", surname: "Ушаков"),
                   User(id: 11, name: "Михаил", surname: "Глотов"),
                   User(id: 12, name: "Иван", surname: "Стародубцев"),
                   User(id: 13, name: "Кирилл", surname: "Жиглов")
    ]
    
    var allGroups: [Group] = [Group(id: 1, name: "Клуб любителей котиков", avatar: UIImage(named: "gpCat")),
                              Group(id: 2, name: "Клуб любителй собак", avatar: UIImage(named: "gpDog")),
                              Group(id: 3, name: "Клуб любителей коняшек", avatar: UIImage(named: "gpHourse"))]
    
    var myGroups: Set<Group> = [Group(id: 1, name: "Клуб любителей котиков", avatar: UIImage(named: "gpCat"))]
    
    
    func getCurrentLogin () -> String {
        guard let currentLogin = UserDefaults.standard.object(forKey: "login") as? String else { return "" }
        return currentLogin
    }
    
    func getCurrentPassword() -> String {
        guard let currentPassword = UserDefaults.standard.object(forKey: "password") as? String else { return "" }
        return currentPassword
    }
    
    func getFirstLettersOfTheName() -> [String] {
        var array = Set<String>()
        for user in friends {
            array.insert(String(user.getFirstNameLetter()))
        }
        return array.sorted()
    }

    func getFirstLettersOfTheSecondName() {
        
    }
    
    
    
    
    
    
}




