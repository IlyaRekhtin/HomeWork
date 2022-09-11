//
//  PhotoViewerInteractor.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import Foundation

final class PhotoViewerInteractor: PhotoViewerInteractorProtocol {
    
    var presenter: PhotoViewerPresenterProtocol?
    
    init(_ presenter: PhotoViewerPresenterProtocol) {
        self.presenter = presenter
    }
    
}
