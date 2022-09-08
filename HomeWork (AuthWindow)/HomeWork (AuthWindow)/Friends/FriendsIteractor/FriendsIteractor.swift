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
    var dataStore: FriendsDataStoreProtocol?
    private var factory = FriendViewModelFactory()
    
    func getFriends() {
        guard let items = dataStore?.start()
        else {
            self.presenter?.interactorDidFetchFriends(with: .failure(Errors.noDataAvailable))
            return
        }
        let friendsViewModels = factory.constructViewModel(for: Array(items.sorted(byKeyPath: "firstName", ascending: true)))
        self.presenter?.interactorDidFetchFriends(with: .success(friendsViewModels))
    }
    
}
