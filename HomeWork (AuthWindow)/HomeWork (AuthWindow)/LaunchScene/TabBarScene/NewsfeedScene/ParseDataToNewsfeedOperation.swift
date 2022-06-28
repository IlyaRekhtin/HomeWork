//
//  ParseDataToNewsfeedOperation.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.06.2022.
//

import Foundation

class ParseDataToNewsfeedOperation: Operation {
    
     var news = [News]()
     var profiles = [Profile]()
     var groups = [Group]()
    
    override func main() {
        guard let fetchDataOperation = dependencies.first as? FetchDataOperation,
              let data = fetchDataOperation.data else {return}
        do {
        let newsfeed = try JSONDecoder().decode(NewsfeedResponse.self, from: data).newsfeed
            news = newsfeed.items
            profiles = newsfeed.profiles
            groups = newsfeed.groups
        } catch {
            print(String(describing: error))
        }
    }
    
   
    
}
