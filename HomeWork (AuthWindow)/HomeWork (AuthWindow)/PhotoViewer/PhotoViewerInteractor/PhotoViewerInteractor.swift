//
//  PhotoViewerInteractor.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import UIKit
import PromiseKit

final class PhotoViewerInteractor: PhotoViewerInteractorProtocol {
    
    weak var presenter: PhotoViewerPresenterProtocol?
    var dataStore: PhotoViewerDataStoreProtocol?
    
    init(_ presenter: PhotoViewerPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getPhoto(url: String) -> UIImage? {

        return dataStore?.cacheService.getPhoto(by: url).value
    }
    
}
