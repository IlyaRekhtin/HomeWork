//
//  APIManager.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.04.2022.
//

import UIKit



class Api {
    
    static var shared = Api()
    private init(){}
    
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
            
            var params: [String: String] {
                switch self {
                case .usersGet:
                    return ["user_id":String(Session.data.id),
                            "fields": "city, counters, crop_photo",
                            "access_token": Session.data.token,
                            "v": Api.shared.apiVersion
                    ]
                case .friendsGet:
                    return ["user_id":String(Session.data.id),
                            "fields": "city, photo_50",
                            "access_token": Session.data.token,
                            "v": Api.shared.apiVersion
                    ]
                case .groupsGet:
                    return ["user_id":String(Session.data.id),
                            "extended": "1",
                            "fields": "description",
                            "access_token": Session.data.token,
                            "v": Api.shared.apiVersion
                    ]
                case .newsfeedGet:
                    return ["filters": "photo, wall_photo",
                            "source_ids": "friends, groups",
                            "access_token": Session.data.token,
                            "v": Api.shared.apiVersion
                    ]
                case .photosGetAll:
                    return ["owner_id": "",
                            "extended": "1",
                            "photo_sizes": "1",
                            "count": "20",
                            "no_service_albums":"1",
                            "access_token": Session.data.token,
                            "v": Api.shared.apiVersion
                    ]
                case .auth:
                    return ["client_id": Api.shared.appID,
                            "display": "mobile",
                            "redirect_uri": "https://oauth.vk.com/blank.html",
                            "scope": "friends, wall, photos, groups",
                            "response_type": "token",
                            "v": Api.shared.apiVersion
                    ]
                case .likeAdd:
                    return ["type": "photo",
                            "owner_id": "",
                            "item_id": "",
                            "access_token": Session.data.token,
                            "v": Api.shared.apiVersion
                    ]
                case .likeDelete:
                    return ["type": "photo",
                            "owner_id": "",
                            "item_id": "",
                            "access_token": Session.data.token,
                            "v": Api.shared.apiVersion
                    ]
                }
            }
        }
    }
    
    
    
    
    // MARK: - private methods
    
    
    
    
    // MARK: - open methods
    /// Создает запрос для перехода к окну авторизации ВК
    /// - Returns: URLRequest
    
    func getAuthRequest() -> URLRequest? {
        let url = URL.configureURL(method: .auth, baseURL: .auth, params: BaseURL.ApiMethod.auth.params)
        let request = URLRequest(url: url)
        return request
    }
    
    func getNewsfeed(complition:@escaping (Newsfeed) -> ()) {
        let url = URL.configureURL(method: .newsfeedGet, baseURL: .api, params: BaseURL.ApiMethod.newsfeedGet.params)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let newsfeed = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed
                complition(newsfeed)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getGroups(complition:@escaping (Groups) -> ()) {
        let url = URL.configureURL(method: .groupsGet, baseURL: .api, params: BaseURL.ApiMethod.groupsGet.params)
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
        let url = URL.configureURL(method: .friendsGet, baseURL: .api, params: BaseURL.ApiMethod.friendsGet.params)
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
        let url = URL.configureURL(method: .usersGet, baseURL: .api, params: BaseURL.ApiMethod.usersGet .params)
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
    enum LikesMethod: String {
        case add = "/method/likes.add"
        case delete = "/method/likes.delete"
    }
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




