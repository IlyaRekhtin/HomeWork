//
//  PhotoViewerPresenter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import UIKit

final class PhotoViewerPresenter: PhotoViewerPresenterProtocol {
    
    var interactor: PhotoViewerInteractorProtocol?
    var router: PhotoViewerRouterProtocol?
    weak var view: PhotoViewerProtocol?
    
    init(_ viewController: PhotoViewerProtocol) {
        self.view = viewController
    }
    
    func getPhoto(url: String) -> UIImage? {
        interactor?.getPhoto(url: url)
    }
}
