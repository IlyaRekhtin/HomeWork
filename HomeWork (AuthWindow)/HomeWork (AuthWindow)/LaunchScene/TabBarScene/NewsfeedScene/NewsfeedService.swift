//
//  NewsfeedService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.05.2022.
//

import Foundation

final class NewsfeedService {
    
    func getNewsfeed() {
        let params = ["filters": "photo, wall_photo",
                      "source_ids": "friends, groups",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
              ]
        let url = URL.configureURL(method: .newsfeedGet, baseURL: .api, params: params)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {return}
            do {
                let news = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed.items
                DataManager.data.saveObjectToDatabase(news)
            }catch{
                print(String(describing: error))
            }
        }.resume()
    }
    
}
