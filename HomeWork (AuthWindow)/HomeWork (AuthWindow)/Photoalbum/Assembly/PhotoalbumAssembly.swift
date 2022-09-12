//
//  PhotoalbumAssembly.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import Foundation

final class PhotoalbumAssembly: PhotoalbumAssemblyProtocol {
    
    func configure(with viewController: PhotoalbumViewController, _ userID: Int, _ userName: String) {
        let presenter = PhotoalbumPresenter(viewController)
        let interactor = PhotoalbumInteractor(presenter)
        let router = PhotoalbumRouter(viewController)
        var dataStore: PhotoalbumDataStoreProtocol = PhotoalbumDataStore()
        
        dataStore.userID = userID
        dataStore.userName = userName
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        interactor.dataStore = dataStore
        presenter.interactor = interactor
        presenter.router = router
       
    }
}

