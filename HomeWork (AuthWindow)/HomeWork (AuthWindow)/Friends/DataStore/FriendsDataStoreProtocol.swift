//
//  DataStoreProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 07.09.2022.
//

import Foundation
import RealmSwift

protocol FriendsDataStoreProtocol: AnyObject {
    func start() ->  Results<Friend>?
}
