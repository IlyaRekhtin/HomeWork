//
//  NetworkService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 07.09.2022.
//

import Foundation
import PromiseKit

final class FriendNetworkService: FriendNetworkServiceProtocol {
    enum AppError: String, Error {
        case urlError = "url not found"
        case decodeError = "don't decode"
        case fetchError = "don't fetch"
    }
    
    func getURL() -> Promise<URL> {
        let params = ["user_id":String(Session.data.id),
                      "fields": "city, photo_50",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
        ]
        return Promise { resolver in
            guard let url = URL.configureURL(method: .friendsGet, baseURL: .api, params: params) else {
                resolver.reject(AppError.urlError)
                return
            }
            resolver.fulfill(url)
        }
    }
    
   func fetchData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else {
                    resolver.reject(AppError.fetchError)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    func parsedData(_ data: Data) -> Promise<[Friend]> {
        return Promise { resolver in
            do {
                let items = try JSONDecoder().decode(FriendsResponse.self, from: data).friends.items
                resolver.fulfill(items)
            }catch{
                resolver.reject(AppError.decodeError)
            }
        }
    }
}
