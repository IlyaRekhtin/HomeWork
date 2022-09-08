//
//  FriendsRouter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import Foundation
import UIKit

final class FriendsRouter: FriendsRouterProtocol {
    
    weak var entryPoint: EntryPoint?
    
    static func start() -> FriendsRouterProtocol {
        let router =  FriendsRouter()
        
        let view: FriendsViewProtocol = FriendsViewController()
        let presenter: FriendsPresenterProtocol = FriendsPresenter()
        let interactor: FriendsIteractorProtocol = FriendsIteractor()
        let dataStore: FriendsDataStoreProtocol = FriendsDataStoreProxy(FriendsDataStore())
        
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.dataStore = dataStore
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entryPoint = view as? EntryPoint
        
        return router
    }
  
    func goToPhotoalbumViewController(for userID: Int,_ name: String) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoalbumViewController") as? PhotoalbumViewController else {return}
        viewController.assembly.configure(with: viewController, userID, name)
        entryPoint?.navigationController?.pushViewController(viewController, animated: true)
        
    }
     
}
