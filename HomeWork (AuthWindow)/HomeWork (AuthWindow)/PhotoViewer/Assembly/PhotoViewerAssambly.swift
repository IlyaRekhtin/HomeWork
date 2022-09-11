//
//  PhotoViewerAssambly.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import UIKit

final class PhotoViewerAssambly: PhotoViewerAssemblyProtocol {
    
    func configure(with viewController: PhotoViewerProtocol, _ photoAlbum: [String], _ index: Int) {
        
        viewController.photoAlbum = photoAlbum
        viewController.currentIndexPuthPhoto = index
        
        let presenter = PhotoViewerPresenter(viewController)
        let interactor = PhotoViewerInteractor(presenter)
        let router = PhotoViewerRouter()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
       
    }
}
