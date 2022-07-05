//
//  NewsfeedService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.05.2022.
//

import Foundation
import PromiseKit
final class NewsfeedService {

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
    
    func parsedData(_ data: Data) -> Promise<Newsfeed> {
        return Promise { resolver in
            do {
                let newsfeed = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed
                resolver.fulfill(newsfeed)
            }catch{
                resolver.reject(AppError.decodeError)
            }
        }
    }
    

    
  
    
//    func getNewsfeed(complition:@escaping (Newsfeed) -> ()) {
//        let params = ["filters": "post, photo, video",
//                      "source_ids": "friends, groups",
//                      "count": "100",
//                      "access_token": Session.data.token,
//                      "v": Api.shared.apiVersion
//        ]
//        guard let url = URL.configureURL(method: .newsfeedGet, baseURL: .api, params: params) else {return}
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            guard let data = data else {return}
//            do {
//
//                let newsfeed = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed
//                DispatchQueue.main.async {
//                    complition(newsfeed)
//                }
//            }catch{
//                print(String(describing: error))
//            }
//        }.resume()
//    }
    
//    func getNewsfeed(from date: String, complition:@escaping (Newsfeed) -> ()) {
//        let params = ["filters": "post, photo, video",
//                      "source_ids": "friends, groups",
//                      "start_date": date,
//                      "count": "100",
//                      "access_token": Session.data.token,
//                      "v": Api.shared.apiVersion
//        ]
//        guard let url = URL.configureURL(method: .newsfeedGet, baseURL: .api, params: params) else {return}
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            guard let data = data else {return}
//            do {
//
//                let newsfeed = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed
//                DispatchQueue.main.async {
//                    complition(newsfeed)
//                }
//            }catch{
//                print(String(describing: error))
//            }
//        }.resume()
//    }
    
//    func getNewsfeed(with startFrom: String, complition:@escaping (Newsfeed) -> ()) {
//        let params = ["filters": "post, photo, video",
//                      "source_ids": "friends, groups",
//                      "start_from": startFrom,
//                      "count": "100",
//                      "access_token": Session.data.token,
//                      "v": Api.shared.apiVersion
//        ]
//        guard let url = URL.configureURL(method: .newsfeedGet, baseURL: .api, params: params) else {return}
//        let request = URLRequest(url: url)
//        
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            guard let data = data else {return}
//            do {
//                
//                let newsfeed = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed
//                DispatchQueue.main.async {
//                    complition(newsfeed)
//                }
//            }catch{
//                print(String(describing: error))
//            }
//        }.resume()
//    }
}
