//
//  GroupViewModelFactory.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 28.08.2022.
//

import Foundation

final class GroupViewModelFactory {
    func constructViewModel(for groups: [Group]) -> [GroupViewModel] {
        return groups.compactMap(self.groupViewModel(for:))
    }
    
    
    
    private func groupViewModel(for group: Group) -> GroupViewModel {
        let id = group.id
        let isMember = group.isMember == 0 ? false : true
        let avatar = group.avatar
        let name = group.name
        let description = group.itemDescription ?? ""
        return GroupViewModel(id: id, isMember: isMember, avatar: avatar, name: name, description: description)
    }
}
