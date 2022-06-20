//
//  SearchFriendsService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.05.2022.
//

import UIKit
import PromiseKit

enum AppError: String, Error {
    case urlError = "url not found"
    case decodeError = "don't decode"
    case fetchError = "don't fetch"
}


final class GroupsService {
    
    func getURL() -> Promise<URL> {
        let params = ["user_id":String(Session.data.id),
                      "extended": "1",
                      "fields": "description",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        
        return Promise { resolver in
            guard let url = URL.configureURL(method: .groupsGet, baseURL: .api, params: params) else {
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
    
    func parsedData(_ data: Data) -> Promise<[Group]> {
        return Promise { resolver in
            do {
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: data).groups.items
                resolver.fulfill(groups)
            }catch{
                resolver.reject(AppError.decodeError)
            }
        }
    }
    
    func writeGroupsToDatabase(_ groups: [Group]) {
        DataManager.data.saveObjectToDatabase(groups)
    }
}
