//
//  FriendViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 28.08.2022.
//

import Foundation
import CloudKit

final class FriendViewModelFactory {
    func constructViewModel(for photos: [Friend]) -> [FriendViewModel] {
        return photos.compactMap(self.friendViewModel(for:))
    }
    
    private func friendViewModel(for friend: Friend) -> FriendViewModel {
        let id = friend.id
        let avatar = friend.photo50
        let name = "\(friend.firstName) \(friend.lastName)"
        let city = friend.city?.title ?? ""
        return FriendViewModel(id: id, avatar: avatar, name: name, city: city)
    }
}
