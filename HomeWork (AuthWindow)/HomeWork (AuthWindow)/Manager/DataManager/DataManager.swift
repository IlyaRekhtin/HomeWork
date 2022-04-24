//
//  DataManager.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 13.04.2022.
//


import UIKit

final class DataManager {
    
    static let data = DataManager()
    
    lazy var friends = [Friend]()
    lazy var users = [User]()
    lazy var newsfeed = [Newsfeed]()
    lazy var groups = [Group]()
    
    
    
    private init(){}
    
    func getFirstLettersOfTheNameList(in nameList: [Friend]) -> [String] {
        var array = Set<String>()
        for user in friends {
            array.insert(String(user.firstName.first!))
        }
        return array.sorted()
    }

    func getFirstLettersOfTheSecondName() {
        //TODO
    }
    
    
    
    
}

