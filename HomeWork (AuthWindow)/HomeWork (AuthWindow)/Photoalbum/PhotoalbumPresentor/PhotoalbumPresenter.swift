//
//  PhotoalbumPresenter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit

final class PhotoalbumPresenter: PhotoalbumPresenterProtocol {
    
    
    
    var interactor: PhotoalbumInteractorProtocol? {
        didSet {
            interactor?.getPhotos()
            interactor?.setNavigationTittle()
        }
    }
    var router: PhotoalbumRouterProtocol?
    weak var view: PhotoalbumViewProtocol?
    
    
    
    init(_ viewController: PhotoalbumViewProtocol) {
        self.view = viewController
        
    }
    
    func interactorDidFetchPhotos(with result: Result<[String], Error>) {
        switch result {
        case .success(let items):
            self.view?.update(with: items)
        case .failure:
            print("Что - то пошло не так!")
        }
    }
    
    func interactorGotANewUsername(_ name: String) {
        view?.setNameForNavigationBar(name)
    }
    
    func getPhoto(url: String, complition: @escaping (UIImage?)-> ()){
        interactor?.getPhoto(url: url, complition: { fetchImage in
            complition(fetchImage)
        })
    }
}
