//
//  APIManager.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.04.2022.
//

import UIKit

final class Api {
    
    static var shared = Api()
    
    
    //MARK: - свойства
    
    let appID = "8157085" // уникальный ключ приложения
    
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
        }
    }
    
    // MARK: - open methods
    /// Создает запрос для перехода к окну авторизации ВК
    /// - Returns: URLRequest
    func getAuthRequest() -> URLRequest? {
        let params = ["client_id": Api.shared.appID,
                      "display": "mobile",
                      "redirect_uri": "https://oauth.vk.com/blank.html",
                      "scope": "friends, wall, photos, groups",
                      "response_type": "token",
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .auth, baseURL: .auth, params: params)
        let request = URLRequest(url: url)
        return request
    }
    
    func getNewsfeed(complition:@escaping ([News]) -> ()) {
        let params = ["filters": "photo, wall_photo",
                      "source_ids": "friends, groups",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .newsfeedGet, baseURL: .api, params: params)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let news = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed.items
                complition(news)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getGroups(complition:@escaping (Groups) -> ()) {
        let params = ["user_id":String(Session.data.id),
                      "extended": "1",
                      "fields": "description",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .groupsGet, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: data).groups
                complition(groups)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getGroupsSearch(searchText: String, complition:@escaping ([Group]) -> ()) {
        let params = ["q":searchText,
                      "type": "group, page",
                      "sort": "0",
                      "count":"10",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .groupsSearch, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: data).groups.items
                complition(groups)
            }catch{
                print(String(describing: error))
                complition([Group]())
            }
        }.resume()
    }
    
    
    func getPhotos(for userID: Int, complition:@escaping (Photos) -> ()){
       let params = ["owner_id": String(userID),
                "extended": "1",
                "photo_sizes": "1",
                "count": "20",
                "no_service_albums":"1",
                "access_token": Session.data.token,
                "v": Api.shared.apiVersion
        ]
        let url = URL.configureURL(method: .photosGetAll, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let photos = try JSONDecoder().decode(PhotosResponse.self, from: data).photos
                complition(photos)
            }catch{
                print(#function)
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getFriends(complition:@escaping (Friends) -> ()) {
        let params = ["user_id":String(Session.data.id),
                      "fields": "city, photo_50",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .friendsGet, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let friends = try JSONDecoder().decode(FriendsResponse.self, from: data).friends
                print(#function)
                complition(friends)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getUser(_ usersId: Int, complition:@escaping (Users)->Void) {
        let params = ["user_id":String(Session.data.id),
                      "fields": "city, counters, crop_photo",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .usersGet, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else {return}
            do {
                let user = try JSONDecoder().decode(UsersResponse.self, from: data).users
                complition(user)
            } catch {
                print(#function)
                print(error.localizedDescription)
            }
        }.resume()
    }
}
//MARK: - Like method
extension Api {
    func likes(for photo: Photo, _ method: Api.BaseURL.ApiMethod) {
        let params = ["type": "photo",
                      "owner_id": String(photo.ownerID),
                      "item_id": String(photo.id),
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion]
        let url = URL.configureURL(method: method, baseURL: .api, params: params)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}




