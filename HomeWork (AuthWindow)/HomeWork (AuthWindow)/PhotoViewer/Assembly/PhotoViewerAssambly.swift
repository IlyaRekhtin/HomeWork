//
//  PhotoViewerAssambly.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import UIKit

final class PhotoViewerAssambly: PhotoViewerAssemblyProtocol {
    
    func configure(with viewController: PhotoViewerProtocol, _ photoAlbum: [Likeble & Reposteble], _ index: Int) {
        
        viewController.photoAlbum = photoAlbum
        viewController.currentIndexPuthPhoto = index
        
        let presenter = PhotoViewerPresenter(viewController)
        let interactor = PhotoViewerInteractor(presenter)
        let router = PhotoViewerRouter()
        let dataStore = PhotoViewerDataStore()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        interactor.dataStore = dataStore
        presenter.interactor = interactor
        presenter.router = router
       
    }
}
