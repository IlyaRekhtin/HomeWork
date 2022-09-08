//
//  PhotoalbumInteractor.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import Foundation

final class PhotoalbumInteractor: PhotoalbumInteractorProtocol {
    
    weak var presenter: PhotoalbumPresenterProtocol?
    var dataStore: PhotoalbumDataStoreProtocol?
    private var factory = PhotoalbumViewModelFactory()
    
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
            guard let items = items,
                  let photoalbumViewModels = self?.factory.constructViewModel(for: items)
            else {return}
            self?.presenter?.interactorDidFetchPhotos(with: .success(photoalbumViewModels))
        })
    }
    
    func setNavigationTittle() {
        guard let name = dataStore?.userName else {return}
        presenter?.interactorGotANewUsername(name)
    }
    
}
