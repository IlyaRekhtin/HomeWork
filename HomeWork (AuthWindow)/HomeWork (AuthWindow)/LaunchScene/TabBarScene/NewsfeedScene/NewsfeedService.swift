//
//  NewsfeedService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.05.2022.
//

import Foundation

final class NewsfeedService {
    
    func getNewsfeed(complition:@escaping (Newsfeed) -> ()) {
        DispatchQueue.global(qos:.userInteractive).async {
        let params = ["filters": "post, photo, video",
                      "source_ids": "friends, groups",
                      "count": "100",
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
                    
                    let newsfeed = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed
                    complition(newsfeed)
                }catch{
                    print(String(describing: error))
                }
            }.resume()
        }
        
    }
}
