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
    
    func start() -> Results<Friend>? {
        networkService.getURL()
            .then(on: .global(), networkService.fetchData(_:))
            .then(on: .global(), networkService.parsedData(_:))
            .done{[weak self] friends in
                self?.databaseService.writeToDatabase(friends)
            }.catch { error in
                print(error.localizedDescription)
            }
        return databaseService.readFromDatabase()
    }
    
    
}
