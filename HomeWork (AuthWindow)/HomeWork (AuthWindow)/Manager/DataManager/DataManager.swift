//
//  DataManager.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 13.04.2022.
//


import UIKit
import SwiftUI

final class DataManager {
    
    static let data = DataManager()
    
    lazy var friends = [Friend]()
    lazy var users = [User]()
    lazy var newsfeed = [Newsfeed]()
    lazy var groups = [Group]()
    lazy var photos = [Photo]()
    
    
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
