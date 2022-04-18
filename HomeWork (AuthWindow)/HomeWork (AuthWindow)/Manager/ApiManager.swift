//
//  APIManager.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.04.2022.
//

import UIKit


struct ApiManager {
    
    static var shared = ApiManager()
    private init(){}
    
    //MARK: - свойства
    lazy private var urlComponents = URLComponents()
    
    private let appID = "8140336" // уникальный ключ приложения
    
    private let apiVersion = "5.131"
    
    private enum BaseURL: String {
        case auth = "oauth.vk.com"
        case api = "api.vk.com"
    }
    
    /// Конечные точки API для получения информации
    enum ApiMethod: String {
        case usersGet = "/method/users.get"
        case friendsGet = "/method/friends.get"
        case groupsGet = "/method/groups.get"
        case newsfeedGet = "/method/newsfeed.get"
        
    }
    
    
    // MARK: - private methods
    /// генерирует URL для авторизации в ВК
    /// - Returns: URL
    private mutating func generateLogInUrl() -> URL?{
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
    private mutating func generateURL(forApiMethod method: ApiMethod) -> URL? {
           self.urlComponents.scheme = "https"
           self.urlComponents.host = BaseURL.api.rawValue
           self.urlComponents.path = method.rawValue
           switch method {
           case .usersGet:
               self.urlComponents.queryItems = [
                URLQueryItem(name: "fields", value: "city, counters"),
                URLQueryItem(name: "access_token", value: Session.data.token),
                URLQueryItem(name: "v", value: apiVersion)
               ]
           case .friendsGet:
               self.urlComponents.queryItems = [
                URLQueryItem(name: "user_id", value: String(Session.data.id)),
                URLQueryItem(name: "access_token", value: Session.data.token),
                URLQueryItem(name: "v", value: apiVersion)
               ]
           case .groupsGet:
               self.urlComponents.queryItems = [
                URLQueryItem(name: "user_id", value: String(Session.data.id)),
                URLQueryItem(name: "access_token", value: Session.data.token),
                URLQueryItem(name: "v", value: apiVersion)
               ]
           case .newsfeedGet:
               self.urlComponents.queryItems = [
                URLQueryItem(name: "access_token", value: Session.data.token),
                URLQueryItem(name: "v", value: apiVersion)
                   
               ]
           }
           return self.urlComponents.url
       }
    // MARK: - open methods
    /// Создает запрос для перехода к окну авторизации ВК
    /// - Returns: URLRequest
    mutating func getAuthRequest() -> URLRequest? {
        guard let url = self.generateLogInUrl() else {return nil}
        let request = URLRequest(url: url)
        return request
    }
 
    mutating func fetchDataFromApi(forMethod method: ApiMethod) {
        guard let url = self.generateURL(forApiMethod: method) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let jsonData = data else {return}
          
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(Users.self, from: jsonData).users.first
                print(user)
            } catch {
                debugPrint(error)
            }
        }.resume()
    }
    
    
    
    

}
