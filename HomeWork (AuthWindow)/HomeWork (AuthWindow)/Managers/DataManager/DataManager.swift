//
//  DataManager.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 13.04.2022.
//


import UIKit
import RealmSwift

final class DataManager {
    
    static let data = DataManager()
    
    var news = [News]()
    var users = [User]()
    var groups = [Group]()
    
    private init(){}
    
}
//MARK: - Realm methods
extension DataManager {
    
    func saveObjectToDatabase<T:Object>(_ items: [T]){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(items, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readFromDatabase<T:Object>(_ item: T.Type) -> Results<T> {
        
        let realm = try! Realm()
        let items = realm.objects(T.self)
        return items
    }
    
    func deleteObjectFromDataBase<T:Object>(for item: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
