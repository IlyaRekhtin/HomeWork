//
//  FriendServiceProxy.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 04.09.2022.
//

import Foundation
import RealmSwift

final class DataStoreProxy: DataStoreProtocol {
    
    
    
    private var service: DataStore
    
    init(_ service: DataStore) {
        self.service = service
    }
    
    func start() -> Results<Friend>? {
        log(.friendsGet)
        return service.start()
    }
}
