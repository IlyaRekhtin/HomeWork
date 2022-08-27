//
//  GroupAdapter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 25.08.2022.
//

import Foundation

final class GroupAdapter {
    
    private let service = GroupsService()
    
    func fetchAndWriteGroupsToRealm() {
        service.getURL()
            .then(on: .global(), service.fetchData(_:))
            .then(on: .global(), service.parsedData(_:)).done(on: .global()) {[weak self] groups in
                self?.service.writeGroupsToDatabase(groups)
            }.catch { error in
                print(error.localizedDescription)
            }
    }
}
