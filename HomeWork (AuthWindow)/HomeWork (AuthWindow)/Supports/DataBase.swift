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
    
    
   
    
    
    
    
    
    
    var friends = [Person(id: 1, name: "Илья Иванов", description: "", avatar: UIImage(named: "ava1")!, album: [Foto(image: UIImage(named: "exp1")!), Foto(image: UIImage(named: "exp2")!)]),
                   Person(id: 2, name: "Анна Пивоварова", description: "", avatar: UIImage(named: "ava2")!),
                   Person(id: 3, name: "Евгений Цветков", description: "", avatar: UIImage(named: "ava3")!, album: [Foto(image: UIImage(named: "exp3")!)]),
                   Person(id: 4, name: "Александр Кроеведов", description: "", avatar: UIImage(named: "ava4")!),
                   Person(id: 5, name: "Женя Смолин", description: "", avatar: UIImage(named: "ava5")!),
                   Person(id: 6, name: "Егор Минеев", description: ""),
                   Person(id: 7, name: "Geprgiy PimenoFF", description: ""),
                   Person(id: 8, name: "Serg Korel", description: ""),
                   Person(id: 9, name: "Максим Усенко", description: ""),
                   Person(id: 10, name: "Станислав Ушаков", description: ""),
                   Person(id: 11, name: "Михаил Глотов", description: ""),
                   Person(id: 12, name: "Иван Стародубцев", description: ""),
                   Person(id: 13, name: "Кирилл Жиглов", description: "")
    ]
    
    let allGroups = [
        Person(id: 1, name: "Клуб любителей котиков", description: "", avatar: UIImage(named: "gpCat")!),
        Person(id: 2, name: "Клуб любителй собак", description: "", avatar: UIImage(named:"gpDog")!),
        Person(id: 3, name: "Клуб любителей коняшек", description: "", avatar: UIImage(named: "gpHourse")!)
    ]
    
    var myGroups: [Person] = [Person(id: 1, name: "Клуб любителей котиков", description: "", avatar: UIImage(named: "gpCat")!)]
    
    
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




