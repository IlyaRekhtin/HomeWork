//
//  ParseDataToFriendsOperation.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.06.2022.
//

import Foundation

class ParseDataToFriendsOperation: AsyncOperation {
    
    var friends = [Friend]()
    
    
    override func main() {
        guard let fetchDataOperation = dependencies.first as? FetchDataOperation,
              let data = fetchDataOperation.data else {return}
        do {
            let friends = try JSONDecoder().decode(FriendsResponse.self, from: data).friends.items
            self.friends = friends
            self.state = .finished
        } catch {
            print(String(describing: error))
        }
    }
    
   
    
}
