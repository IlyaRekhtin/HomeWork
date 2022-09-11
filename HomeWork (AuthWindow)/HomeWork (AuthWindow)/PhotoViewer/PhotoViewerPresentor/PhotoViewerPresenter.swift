//
//  PhotoViewerPresenter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import Foundation

final class PhotoViewerPresenter: PhotoViewerPresenterProtocol {
    
    var interactor: PhotoViewerInteractorProtocol?
    var router: PhotoViewerRouterProtocol?
    var view: PhotoViewerProtocol?
    
    init(_ viewController: PhotoViewerProtocol) {
        self.view = viewController
        
    }
}
