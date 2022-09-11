//
//  GroupsPresenter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import UIKit

final class GroupsPresenter: GroupsPresenterProtocol {
    
    var interactor: GroupsInteractorProtocol? {
        didSet {
            interactor?.getGroups()
        }
    }
    var router: GroupsRouterProtocol?
    weak var view: GroupsViewProtocol?
    
    func interactorDidFetchGroups(with result: Result<[GroupViewModel], Error>) {
        switch result {
        case .success(let groupViewModels):
            self.view?.update(with: groupViewModels)
        case .failure:
            self.view?.update(with: "К сожалению что - то пошло не так!")
        }
    }
    
    func getPhoto(url: String, complition: @escaping (UIImage?)-> ()){
        interactor?.getPhoto(url: url, complition: { fetchImage in
            complition(fetchImage)
        })
    }
}
