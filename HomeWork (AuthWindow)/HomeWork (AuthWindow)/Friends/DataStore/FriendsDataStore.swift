//
//  DataStore.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 07.09.2022.
//

import Foundation
import RealmSwift
import PromiseKit


final class FriendsDataStore: FriendsDataStoreProtocol {
    var networkService: FriendNetworkServiceProtocol = FriendNetworkService()
    var databaseService: FriendDatabaseProtocol = FriendDatabaseService()
    
    func start() ->  Results<Friend>?{
        let friends = try? networkService.getURL()
            .then(on: .global(), networkService.fetchData(_:))
            .then(on: .global(), networkService.parsedData(_:)).wait()
        self.databaseService.writeToDatabase(friends)
        return self.databaseService.readFromDatabase()
    }
    
    func getFriends() -> Results<Friend>? {
        self.databaseService.readFromDatabase()
    }
    
    
}
