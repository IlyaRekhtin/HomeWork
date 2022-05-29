//
//  FriendsService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.05.2022.
//

import UIKit


final class FriendsService {
    
    func getFriends() {
        let params = ["user_id":String(Session.data.id),
                      "fields": "city, photo_50",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .friendsGet, baseURL: .api, params: params)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let friends = try JSONDecoder().decode(FriendsResponse.self, from: data).friends.items
                DataManager.data.saveObjectToDatabase(friends)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
}
