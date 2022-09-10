//
//  PhotoalbumPresenterProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit

protocol PhotoalbumPresenterProtocol: AnyObject {
    var interactor: PhotoalbumInteractorProtocol? { get set }
    var router: PhotoalbumRouterProtocol? { get set }
    var view: PhotoalbumViewProtocol? {get set}
    
    func interactorDidFetchPhotos(with result:  Result<[String], Error>)
    func interactorGotANewUsername(_ name: String)
    func getPhoto(url: String, complition: @escaping (UIImage?)-> ())
}
