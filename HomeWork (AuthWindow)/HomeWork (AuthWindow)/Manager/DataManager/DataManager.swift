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
    
    var myFriends: Results<Friend>?
    var myGroups: Results<Group>?
    var friendsPhotos: Results<Photo>?
    
    ///Newsfeed
    var myNewsfeed: Newsfeed?
//    lazy var myNews = myNewsfeed?.last?.items
//    lazy var usersForMyNews = myNewsfeed?.last?.profiles
//    lazy var groupsForMyNews = myNewsfeed?.last?.groups
    
    private init(){}
    
    func getFirstLettersOfTheNameList(in nameList: Results<Friend>) -> [String] {
        
        var array = Set<String>()
        for user in nameList {
            array.insert(String(user.firstName.first!))
        }
        return array.sorted()
    }
    func getFirstLettersOfTheSecondName() {
        //TODO
    }
    
    
    //MARK: - helpers
    func getPhotoUrl(with size: TypeEnum, for photos: [Photo] ) -> [URL] {
        var urlsPhotosWithSize = [URL]()
        for photo in photos {
            for photoSize in photo.sizes {
                if photoSize.type  == size.rawValue {
                    guard let url = URL(string: photoSize.url) else {continue}
                    urlsPhotosWithSize.append(url)
                }
            }
        }
        return urlsPhotosWithSize
    }
}

//MARK: - Realm methods
extension DataManager {
    
    
    func saveToDatabase<T:Object>(_ item: T){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(item, update: .modified)
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
    
    func updateValueFromRealm<T:Object>(for item: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(item, update: .all)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
