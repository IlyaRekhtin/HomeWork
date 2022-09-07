//
//  FriendViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 28.08.2022.
//

import Foundation
import UIKit

final class FriendViewModelFactory {
    
    let isNotAvatarImage = UIImage(systemName: "person.circle.fill")
    var photoCachService: PhotoCachesServiceProtocol = PhotoCachesService()
    
    func constructViewModel(for photos: [Friend]) -> [FriendViewModel] {
        return photos.compactMap(self.friendViewModel(for:))
    }
    
    private func friendViewModel(for friend: Friend) -> FriendViewModel {
        let id = friend.id
        let avatar = getAvatarImage(url: friend.photo50) ?? self.isNotAvatarImage!
        let name = "\(friend.firstName) \(friend.lastName)"
        let city = friend.city?.title ?? ""
        return FriendViewModel(id: id, avatar: avatar, name: name, city: city)
    }
    
    private func getAvatarImage(url: String) -> UIImage? {
        return self.photoCachService.getPhoto(by: url)
    }
}
