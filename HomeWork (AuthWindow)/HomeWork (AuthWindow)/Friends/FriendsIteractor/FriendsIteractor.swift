//
//  FriendsIteractor.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import Foundation
import RealmSwift

enum Errors: Error {
    case noDataAvailable
}

final class FriendsIteractor: FriendsIteractorProtocol {
    
    weak var presenter: FriendsPresenterProtocol?
    var dataStore: DataStoreProtocol?
    private let factory = FriendViewModelFactory()
//    private var friends: Results<Friend>?
//    private var token: NotificationToken?
    
    func getFriends() {
        guard let items = dataStore?.start()
        else {
            self.presenter?.interactorDidFetchFriends(with: .failure(Errors.noDataAvailable))
            return
        }
//        friends = items
        let friendsViewModels = factory.constructViewModel(for: Array(items.sorted(byKeyPath: "firstName", ascending: true)))
        self.presenter?.interactorDidFetchFriends(with: .success(friendsViewModels))
    }
    
//    func  addNotificationToken() {
//        self.token = friends?.observe { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .update(_,
//                         deletions: let deletions,
//                         insertions: let insertions,
//                         modifications: let modifications):
//
//
//                self.presenter?.interactorDidFetchFriends(with: )
//            case .error(let error):
//                print("\(error)")
//            default:
//                break
//            }
//        }
//    }
    
    
}
