//
//  GroupsPresenterProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import UIKit

protocol GroupsPresenterProtocol: AnyObject {
    var interactor: GroupsInteractorProtocol? { get set }
    var router: GroupsRouterProtocol? { get set }
    var view: GroupsViewProtocol? {get set}
    
    func interactorDidFetchGroups(with result: Result<[GroupViewModel], Error>)
    func getPhoto(url: String, complition: @escaping (UIImage?)-> ())
}
