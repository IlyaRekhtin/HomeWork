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
    lazy private var urlComponents = URLComponents()
    
    private let appID = "8147273" // уникальный ключ приложения
    
    private let apiVersion = "5.131"
    
    private enum BaseURL: String {
        case auth = "oauth.vk.com"
        case api = "api.vk.com"
    }
    
    /// Конечные точки API для получения информации
    private enum ApiMethod: String {
        case usersGet = "/method/users.get"
        case friendsGet = "/method/friends.get"
        case groupsGet = "/method/groups.get"
        case newsfeedGet = "/method/newsfeed.get"
        case photosGetAll = "/method/photos.getAll"
    }
    
    
    // MARK: - private methods
    /// генерирует URL для авторизации в ВК
    /// - Returns: URL
    private func generateLogInUrl() -> URL?{
        self.urlComponents.scheme = "https"
        self.urlComponents.host = BaseURL.auth.rawValue
        self.urlComponents.path = "/authorize"
        self.urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: appID),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends, wall, photos, groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: apiVersion)
        ]
        return self.urlComponents.url
    }
    
    /// Метод для создания URL с конечной точкой выбранного метода API
    /// - Parameter method: Перечисление содержащее возможные конечные точки API
    /// - Returns: URL
    private func generateURL(forUsers usersID: Int?,withApiMethod method: ApiMethod) -> URL? {
        self.urlComponents.scheme = "https"
        self.urlComponents.host = BaseURL.api.rawValue
        self.urlComponents.path = method.rawValue
        switch method {
        case .usersGet:
            self.urlComponents.queryItems = [
                URLQueryItem(name: "user_id", value: String(usersID ?? Session.data.id)),
                URLQueryItem(name: "fields", value: "city, counters, crop_photo"),
                URLQueryItem(name: "access_token", value: Session.data.token),
                URLQueryItem(name: "v", value: apiVersion)
            ]
        case .friendsGet:
            self.urlComponents.queryItems = [
                URLQueryItem(name: "user_id", value: String(usersID ?? Session.data.id)),
                URLQueryItem(name: "fields", value: "city, photo_50"),
                URLQueryItem(name: "access_token", value: Session.data.token),
                URLQueryItem(name: "v", value: apiVersion)
            ]
        case .groupsGet:
            self.urlComponents.queryItems = [
                URLQueryItem(name: "user_id", value: String(usersID ?? Session.data.id)),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "fields", value: "description"),
                URLQueryItem(name: "access_token", value: Session.data.token),
                URLQueryItem(name: "v", value: apiVersion)
            ]
        case .newsfeedGet:
            self.urlComponents.queryItems = [
//                URLQueryItem(name: "filters", value: "photo"),
//                URLQueryItem(name: "return_banned", value: "0"),
                URLQueryItem(name: "access_token", value: Session.data.token),
                URLQueryItem(name: "v", value: apiVersion)
                
            ]
        case .photosGetAll:
            self.urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: String(usersID!)),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "photo_sizes", value: "1"),
                URLQueryItem(name: "count", value: "20"),
                URLQueryItem(name: "no_service_albums", value: "1"),
                URLQueryItem(name: "access_token", value: Session.data.token),
                URLQueryItem(name: "v", value: apiVersion)
                
            ]
        }
        
        
        return self.urlComponents.url
    }
    
    // MARK: - open methods
    /// Создает запрос для перехода к окну авторизации ВК
    /// - Returns: URLRequest
    func getAuthRequest() -> URLRequest? {
        guard let url = self.generateLogInUrl() else {return nil}
        let request = URLRequest(url: url)
        return request
    }
    
    func getNewsfeeds(complition:@escaping (Groups) -> ()) {
        guard let url = self.generateURL(forUsers: nil, withApiMethod: .newsfeedGet) else {return}
        print(url)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let newsfeed = try JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
                print(newsfeed)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getGroups(complition:@escaping (Groups) -> ()) {
        guard let url = self.generateURL(forUsers: nil, withApiMethod: .groupsGet) else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let groups = try JSONDecoder().decode(Groups.self, from: data)
                complition(groups)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getPhotos(for userID: Int, complition:@escaping (Photos) -> ()){
        guard let url = self.generateURL(forUsers: userID, withApiMethod: .photosGetAll) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let photos = try JSONDecoder().decode(Photos.self, from: data)
                complition(photos)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getFriends(complition:@escaping (Friends) -> ()) {
        guard let url = self.generateURL(forUsers: nil, withApiMethod: .friendsGet) else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let friends = try JSONDecoder().decode(Friends.self, from: data)
                
                complition(friends)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getUser(_ usersId: Int, complition:@escaping (User)->Void) {
        guard let url = self.generateURL(forUsers: usersId, withApiMethod: .usersGet) else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else {return}
            do {
                guard let user = try JSONDecoder().decode(Users.self, from: data).users.first else {return}
                complition(user)
            } catch {
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
    func likes(for photo: Photo, _ method: LikesMethod) {
        self.urlComponents.scheme = "https"
        self.urlComponents.host = BaseURL.api.rawValue
        self.urlComponents.path = method.rawValue
        self.urlComponents.queryItems = [
            URLQueryItem(name: "type", value: "photo"),
            URLQueryItem(name: "owner_id", value: String(photo.ownerID)),
            URLQueryItem(name: "item_id", value: String(photo.id)),
            URLQueryItem(name: "access_token", value: Session.data.token),
            URLQueryItem(name: "v", value: apiVersion)
        ]
        guard let url = urlComponents.url else {return}
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    
    
    
}




