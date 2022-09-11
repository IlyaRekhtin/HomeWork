//
//  PhotoViewerInteractorProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import Foundation

protocol PhotoViewerInteractorProtocol: AnyObject {
    var presenter: PhotoViewerPresenterProtocol? {get set}
}
