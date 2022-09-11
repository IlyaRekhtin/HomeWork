//
//  GroupsInteractor.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import UIKit

final class GroupsInteractor: GroupsInteractorProtocol {
    
    weak var presenter: GroupsPresenterProtocol?
    var dataStore: GroupsDataStoreProtocol?
    private var factory = GroupViewModelFactory()
    
    func getGroups() {
        guard let items = dataStore?.start()
        else {
            self.presenter?.interactorDidFetchGroups(with: .failure(Errors.noDataAvailable))
            return
        }
        let groupsViewModels = factory.constructViewModel(for: Array(items))
        self.presenter?.interactorDidFetchGroups(with: .success(groupsViewModels))
    }
    
    func getPhoto(url: String, complition: @escaping (UIImage?) -> ()){
        dataStore?.cacheService.getPhoto(by: url).done({ image in
            complition(image)
        }).catch({ error in
            print(error)
        })
    }
    
}
