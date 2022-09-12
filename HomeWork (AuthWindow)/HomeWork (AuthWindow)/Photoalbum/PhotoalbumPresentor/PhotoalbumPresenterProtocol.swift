//
//  PhotoalbumPresenterProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit
import RealmSwift

protocol PhotoalbumPresenterProtocol: AnyObject {
    var interactor: PhotoalbumInteractorProtocol? { get set }
    var router: PhotoalbumRouterProtocol? { get set }
    var view: PhotoalbumViewProtocol? {get set}
    
    func interactorDidFetchPhotos(with result: Result<[PhotoalbumViewModel], Error>)
    func interactorGotANewUsername(_ name: String)
    func getPhoto(url: String, complition: @escaping (UIImage?)-> ())
    func presentPhotoViewer(_ photoalbum: [Likeble & Reposteble], _ index: Int)
}
