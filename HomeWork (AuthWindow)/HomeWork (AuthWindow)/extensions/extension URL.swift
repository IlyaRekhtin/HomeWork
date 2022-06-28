//
//  extension URL.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 15.05.2022.
//

import Foundation

extension URL {
    static func configureURL(method: Api.BaseURL.ApiMethod,
                             baseURL: Api.BaseURL,
                             params: [String: String]) -> URL? {
        var queryItems: [URLQueryItem] = []

        params.forEach { param, value in
            queryItems.append(URLQueryItem(name: param, value: value))
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL.rawValue
        urlComponents.path = method.rawValue
        urlComponents.queryItems = queryItems

        let url = urlComponents.url 
        return url
    }
    
}
