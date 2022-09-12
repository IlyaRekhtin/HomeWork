//
//  GroupsDataStore.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import Foundation
import PromiseKit
import RealmSwift

final class GroupsDataStore: GroupsDataStoreProtocol {
    var networkService: GroupsNetworkServiceProtocol = GroupsNetworkService()
    var databaseService: GroupsDatabaseProtocol = GroupsDatabaseService()
    var cacheService: GroupsCacheServiceProtocol = GroupsCacheService()
    
    func start() ->  Results<Group>?{
        let groups = try? networkService.getURL()
            .then(on: .global(), networkService.fetchData(_:))
            .then(on: .global(), networkService.parsedData(_:)).wait()
        self.databaseService.writeToDatabase(groups)
        return self.databaseService.readFromDatabase()
    }
    
    func getGriups() -> Results<Group>? {
        self.databaseService.readFromDatabase()
    }
}
