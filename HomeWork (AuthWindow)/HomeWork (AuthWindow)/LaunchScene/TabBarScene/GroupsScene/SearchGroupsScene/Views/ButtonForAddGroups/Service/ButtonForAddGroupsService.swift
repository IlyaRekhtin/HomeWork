//
//  ButtonForAddGroups.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 02.06.2022.
//

import Foundation

class ButtonForAddGroupsService {
    
    func groupNetwork(_ groupId: Int,_ method: Api.BaseURL.ApiMethod ) {
        let params = ["group_id": String(groupId),
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
        ]
        guard let url = URL.configureURL(method: method, baseURL: .api, params: params) else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
