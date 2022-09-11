//
//  GroupsDataStoreProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import Foundation
import RealmSwift

protocol GroupsDataStoreProtocol: AnyObject {
    var networkService: GroupsNetworkServiceProtocol {get set}
    var databaseService: GroupsDatabaseProtocol {get set}
    var cacheService: GroupsCacheServiceProtocol {get set}
    
    func start() ->  Results<Group>?
}
