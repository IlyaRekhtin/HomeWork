//
//  FriendServiceProxy.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 04.09.2022.
//

import Foundation
import RealmSwift

final class FriendsDataStoreProxy: FriendsDataStoreProtocol {
    
    private var service: FriendsDataStore
    
    init(_ service: FriendsDataStore) {
        self.service = service
    }
    
    func start() -> Results<Friend>? {
        log(.friendsGet)
        return service.start()
    }
}
