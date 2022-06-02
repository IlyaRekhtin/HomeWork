//
//  SearchFriendsService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.05.2022.
//

import UIKit

final class GroupsService {
    
    
    
    func getGroups() {
        let params = ["user_id":String(Session.data.id),
                      "extended": "1",
                      "fields": "description",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .groupsGet, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: data).groups.items
                DispatchQueue.main.async {
                    DataManager.data.saveObjectToDatabase(groups)
                }
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
    func getGroupsSearch(searchText: String, complition:@escaping ([Group]) -> ()) {
        let params = ["q":searchText,
                      "type": "group, page",
                      "sort": "0",
                      "count":"10",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .groupsSearch, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let groups = try JSONDecoder().decode(GroupsResponse.self, from: data).groups.items
                complition(groups)
            }catch{
                print(String(describing: error))
                complition([Group]())
            }
        }.resume()
    }
    
}
