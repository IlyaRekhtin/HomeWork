//
//  FriendsRouter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import Foundation

final class FriendsRouter: FriendsRouterProtocol {
    
    var entryPoint: EntryPoint?
    
    static func start() -> FriendsRouterProtocol {
        let router =  FriendsRouter()
        
        let view: FriendsViewProtocol = FriendsViewController()
        let presenter: FriendsPresenterProtocol = FriendsPresenter()
        let interactor: FriendsIteractorProtocol = FriendsIteractor()
        let dataStore: DataStoreProtocol = DataStoreProxy(DataStore())
        
        
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
