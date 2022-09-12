//
//  PhotoViewerPresenter.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import UIKit

protocol PhotoViewerPresenterProtocol: AnyObject {
    var interactor: PhotoViewerInteractorProtocol? { get set }
    var router: PhotoViewerRouterProtocol? { get set }
    var view: PhotoViewerProtocol? {get set}
    
    func getPhoto(url: String) -> UIImage?
}
