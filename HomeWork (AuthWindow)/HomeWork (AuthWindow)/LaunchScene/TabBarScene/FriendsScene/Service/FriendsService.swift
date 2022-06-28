//
//  FriendsService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.05.2022.
//

import UIKit
import RealmSwift


final class FriendsService {
    
    func fetchFriendsFromNetworkAndSaveToDatabase() {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        let params = ["user_id":String(Session.data.id),
                      "fields": "city, photo_50",
                      "access_token": Session.data.token,
                      "v": Api.shared.apiVersion
        ]
        
        guard let url = URL.configureURL(method: .friendsGet, baseURL: .api, params: params) else {return}
        let request = URLRequest(url: url)
        
        let fetchDataOperation = FetchDataOperation(for: request)
        queue.addOperation(fetchDataOperation)
        
        let parseDataOperation = ParseDataToFriendsOperation()
        parseDataOperation.addDependency(fetchDataOperation)
        queue.addOperation(parseDataOperation)
        
        let writeDataToDatabase = WriteDataToDatabaseOperation(parseDataOperation.friends)
        writeDataToDatabase.addDependency(parseDataOperation)
        queue.addOperation(writeDataToDatabase)
    }
    
    func readFriendsFromDatabase() -> Results<Friend>{
        let friends = DataManager.data.readFromDatabase(Friend.self)
        return friends
    }
    
    
    
}
