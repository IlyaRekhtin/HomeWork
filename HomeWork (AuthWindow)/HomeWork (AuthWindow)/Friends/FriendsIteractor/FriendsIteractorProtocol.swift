//
//  FriendsIteractorProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import Foundation

protocol FriendsIteractorProtocol: AnyObject {
    var presenter: FriendsPresenterProtocol? {get set}
    var dataStore: DataStoreProtocol? {get set}
    
    func getFriends()
}
