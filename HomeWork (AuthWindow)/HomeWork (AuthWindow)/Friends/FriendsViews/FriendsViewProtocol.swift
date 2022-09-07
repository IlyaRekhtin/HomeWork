//
//  FriendsViewProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import Foundation

protocol FriendsViewProtocol: AnyObject {
    var presenter: FriendsPresenterProtocol? {get set}
    
    func update(with friends: [FriendViewModel])
    func update(with error: String)
}
