//
//  AuthService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.05.2022.
//

import Foundation

final class AuthService {
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
}
