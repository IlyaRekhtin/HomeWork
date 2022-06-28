//
//  APIManager.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.04.2022.
//

import UIKit

final class Api {
    
    static var shared = Api()
    
    let appID = "8180152" // уникальный ключ приложения
    let apiVersion = "5.131"
    
    enum BaseURL: String {
        case auth = "oauth.vk.com"
        case api = "api.vk.com"
        /// Конечные точки API для получения информации
        enum ApiMethod: String {
            case usersGet = "/method/users.get"
            case friendsGet = "/method/friends.get"
            case groupsGet = "/method/groups.get"
            case newsfeedGet = "/method/newsfeed.get"
            case photosGetAll = "/method/photos.getAll"
            case auth = "/authorize"
            case likeAdd = "/method/likes.add"
            case likeDelete = "/method/likes.delete"
            case groupsSearch = "/method/groups.search"
            case joinGroup = "/method/groups.join"
            case leaveGroup = "/method/groups.leave"
        }
    }
    
}


