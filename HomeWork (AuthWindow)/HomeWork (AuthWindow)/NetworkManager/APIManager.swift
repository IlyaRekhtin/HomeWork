//
//  APIManager.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.04.2022.
//

import UIKit


final class ApiManager {
    
    static let shared = ApiManager()
    private init(){}
    
    //MARK: - свойства
    lazy private var sessionConfiguration = URLSessionConfiguration.default
    lazy private var session = URLSession(configuration: sessionConfiguration)
    lazy private var baseUrl = URLComponents()
    lazy private var clientId = "8140336"
    lazy private var apiVersion = "5.131"
    
    enum BaseUrlEnum: String {
        case auth = "oauth.vk.com"
        case api = "api.vk.com"
    }
    
    enum ApiMethodEnum: String {
        case auth = "/authorize"
        case friendsGet = "/method/friends.get"
        case groupsGet = "/method/groups.get"
        case newsfeedGet = "/method/newsfeed.get"
        
    }
    
    
  // MARK: - private methods
    
   
    
    
    
   
    // MARK: - open methods
    
    func getURL(for baseURL: BaseUrlEnum, and method: ApiMethodEnum) -> URL? {
        self.baseUrl.scheme = "https"
        self.baseUrl.host = baseURL.rawValue
        self.baseUrl.path = method.rawValue
        switch method {
        case .auth:
            self.baseUrl.queryItems = [
                URLQueryItem(name: "client_id", value: clientId),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                URLQueryItem(name: "scope", value: "friends, wall, photos, groups"),
                URLQueryItem(name: "response_type", value: "token"),
                URLQueryItem(name: "v", value: apiVersion)
            ]
        case .friendsGet:
            self.baseUrl.queryItems = [
                URLQueryItem(name: "user_id", value: String(UserSessionData.data.id)),
                URLQueryItem(name: "access_token", value: UserSessionData.data.token),
                URLQueryItem(name: "v", value: apiVersion)
            ]
        case .groupsGet:
            self.baseUrl.queryItems = [
                URLQueryItem(name: "user_id", value: String(UserSessionData.data.id)),
                URLQueryItem(name: "access_token", value: UserSessionData.data.token),
                URLQueryItem(name: "v", value: apiVersion)
            ]
        case .newsfeedGet:
            self.baseUrl.queryItems = [
                URLQueryItem(name: "access_token", value: UserSessionData.data.token),
                URLQueryItem(name: "v", value: apiVersion)
                
            ]
        }
        
        return self.baseUrl.url
    }
    
    
    

}
