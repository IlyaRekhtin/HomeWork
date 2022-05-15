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
    
    lazy var myFriends = [Friend]()
    lazy var myGroups = [Group]()
    lazy var friendsPhotos = [Photo]()
    
    ///Newsfeed
    lazy var myNewsfeed = [Newsfeed]()
    lazy var myNews = myNewsfeed.last?.items
    lazy var usersForMyNews = myNewsfeed.last?.profiles
    lazy var groupsForMyNews = myNewsfeed.last?.groups
    
    let config: Realm.Configuration = {
        var config = Realm.Configuration()
        //        config.deleteRealmIfMigrationNeeded = true
        return config
    }()
    
    private init(){}
    
    func getFirstLettersOfTheNameList(in nameList: [Friend]) -> [String] {
        
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
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(item)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readFromDatabase<T:Object>(_ item: T.Type) -> [T]{
        do {
            let realm = try Realm(configuration: config)
            let items = realm.objects(T.self)
            return Array(items)
        } catch {
            print(error.localizedDescription)
            return Array()
        }
    }
    
    func updateValueFromRealm<T:Object>(for item: T) {
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(item, update: .all)
            }
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
