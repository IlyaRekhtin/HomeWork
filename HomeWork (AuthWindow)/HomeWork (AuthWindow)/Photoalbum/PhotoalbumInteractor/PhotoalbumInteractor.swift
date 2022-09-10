//
//  PhotoalbumInteractor.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit
import PromiseKit

final class PhotoalbumInteractor: PhotoalbumInteractorProtocol {
    
    weak var presenter: PhotoalbumPresenterProtocol?
    var dataStore: PhotoalbumDataStoreProtocol?
    
    init(_ presenter: PhotoalbumPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getPhotos() {
        guard let userID = dataStore?.userID
        else {
            self.presenter?.interactorDidFetchPhotos(with: .failure(Errors.noDataAvailable))
            return
        }
        dataStore?.start(for: userID, complition: {[weak self] items in
            self?.presenter?.interactorDidFetchPhotos(with: .success(items))
        })
    }
    
    func setNavigationTittle() {
        guard let name = dataStore?.userName else {return}
        presenter?.interactorGotANewUsername(name)
    }
    
    func getPhoto(url: String, complition: @escaping (UIImage?) -> ()){
        dataStore?.cacheService.getPhoto(by: url).done({ image in
            complition(image)
        }).catch({ error in
            print(error)
        })
        
    }
}
