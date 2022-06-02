//
//  ButtonForAddGroups.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 02.06.2022.
//

import Foundation

class ButtonForAddGroupsService {
    
    func joinGroup(_ group: Group) {
        let params = ["group_id": String(group.id),
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
        ]
        let url = URL.configureURL(method: .joinGroup, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func leaveGroup(_ group: Group) {
        let params = ["group_id": String(group.id),
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
        ]
        let url = URL.configureURL(method: .leaveGroup, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
