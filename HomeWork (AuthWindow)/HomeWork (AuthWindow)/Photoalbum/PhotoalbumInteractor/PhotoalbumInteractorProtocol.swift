//
//  PhotoalbumInteractorProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit

protocol PhotoalbumInteractorProtocol: AnyObject {
    var presenter: PhotoalbumPresenterProtocol? {get set}
    var dataStore: PhotoalbumDataStoreProtocol? {get set}
    
    func getPhotos()
    func setNavigationTittle()
    func getPhoto(url: String, complition: @escaping (UIImage?) -> ())
    
}

