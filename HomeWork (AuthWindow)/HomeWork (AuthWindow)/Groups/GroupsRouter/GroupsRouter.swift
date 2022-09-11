//
//  GroupsRouter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import Foundation

final class GroupsRouter: GroupsRouterProtocol {
    
    weak var entryPoint: EntryPoint?
    
    static func start() -> GroupsRouterProtocol {
        let router =  GroupsRouter()
        
        let view: GroupsViewProtocol = GroupsViewController()
        let presenter: GroupsPresenterProtocol = GroupsPresenter()
        let interactor: GroupsInteractorProtocol = GroupsInteractor()
        let dataStore: GroupsDataStoreProtocol = GroupsDataStore()
        
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.dataStore = dataStore
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entryPoint = view as? EntryPoint
        
        return router
    }
}

