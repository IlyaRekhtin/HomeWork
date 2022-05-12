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
    lazy var myNews = [News]()
    lazy var usersForMyNews = [User]()
    lazy var groupsForMyNews = [Group]()
    
    private init(){}
    
    func getFirstLettersOfTheNameList(in nameList: Results<Friend>?) -> [String] {
        guard let nameList = nameList else {return Array()}

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
    func saveToDatabase<T:Object>(_ items: [T]){
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(items)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readFromDatabase<T:Object>(_ item: T) -> Results<T>? {
            do {
                let realm = try Realm()
                let items = realm.objects(T.self)
                return items
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
}
