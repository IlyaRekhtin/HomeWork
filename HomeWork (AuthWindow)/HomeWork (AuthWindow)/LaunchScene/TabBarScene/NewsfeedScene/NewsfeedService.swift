//
//  NewsfeedService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.05.2022.
//

import Foundation
import PromiseKit

final class NewsfeedService: NetworkServiceProtocol {
    enum AppError: String, Error {
        case urlError = "url not found"
        case decodeError = "don't decode"
        case fetchError = "don't fetch"
    }

    func getURL() -> Promise<URL> {
        let params = ["filters": "post, photo, video",
                      "source_ids": "friends, groups",
                      "count": "10",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
        ]
        
        return Promise { resolver in
            guard let url = URL.configureURL(method: .newsfeedGet, baseURL: .api, params: params) else {
                resolver.reject(AppError.urlError)
                return
            }
            resolver.fulfill(url)
        }
    }
    
    func getURL(from date: String) -> Promise<URL> {
        let params = ["filters": "post, photo, video",
                      "source_ids": "friends, groups",
                      "count": "10",
                      "start_from": "next_from",
                      "start_time": date,
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
        ]
        
        return Promise { resolver in
            guard let url = URL.configureURL(method: .newsfeedGet, baseURL: .api, params: params) else {
                resolver.reject(AppError.urlError)
                return
            }
            resolver.fulfill(url)
        }
    }
    
    func getURL(with nextFrom: String) -> Promise<URL> {
        let params = ["filters": "post, photo, video",
                      "source_ids": "friends, groups",
                      "start_from": nextFrom,
                      "count": "10",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
        ]
        
        return Promise { resolver in
            guard let url = URL.configureURL(method: .newsfeedGet, baseURL: .api, params: params) else {
                resolver.reject(AppError.urlError)
                print(#function)
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
                    print(#function)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    func parsedData(_ data: Data) -> Promise<Newsfeed> {
        return Promise { resolver in
            do {
                let newsfeed = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed
                resolver.fulfill(newsfeed)
            }catch{
                resolver.reject(AppError.decodeError)
                debugPrint(error)
                print(#function)
            }
        }
    }
}
