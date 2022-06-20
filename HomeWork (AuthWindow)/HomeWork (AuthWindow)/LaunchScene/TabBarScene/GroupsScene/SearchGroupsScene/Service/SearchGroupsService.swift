//
//  SearchGroupsService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 21.06.2022.
//

import Foundation

final class SearchGroupsService {
    func getGroupsSearch(searchText: String, complition:@escaping ([Group]) -> ()) {
        let params = ["q":searchText,
                      "type": "group, page",
                      "sort": "0",
                      "count":"10",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        guard let url = URL.configureURL(method: .groupsSearch, baseURL: .api, params: params) else {return}
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
