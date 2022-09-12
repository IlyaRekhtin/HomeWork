//
//  PhotoViewerInteractorProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import UIKit

protocol PhotoViewerInteractorProtocol: AnyObject {
    var presenter: PhotoViewerPresenterProtocol? {get set}
    func getPhoto(url: String) -> UIImage?
}
