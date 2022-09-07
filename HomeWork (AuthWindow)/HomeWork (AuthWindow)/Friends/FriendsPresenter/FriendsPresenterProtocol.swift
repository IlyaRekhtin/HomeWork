//
//  FriendsPresenterProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import Foundation

protocol FriendsPresenterProtocol: AnyObject {
    var interactor: FriendsIteractorProtocol? { get set }
    var router: FriendsRouterProtocol? { get set }
    var view: FriendsViewProtocol? {get set}
    
    func interactorDidFetchFriends(with result:  Result<[FriendViewModel], Error>)
}
