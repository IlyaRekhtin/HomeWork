//
//  FriendsPresenter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import Foundation

final class FriendsPresenter: FriendsPresenterProtocol {
    
    var interactor: FriendsIteractorProtocol? {
        didSet {
            interactor?.getFriends()
        }
    }
    
    var router: FriendsRouterProtocol?
    
    weak var view: FriendsViewProtocol?
    
    func interactorDidFetchFriends(with result: Result<[FriendViewModel], Error>) {
        switch result {
        case .success(let friendsViewModel):
            self.view?.update(with: friendsViewModel)
        case .failure:
            self.view?.update(with: "К сожалению что - то пошло не так!")
        }
    }
    
}
