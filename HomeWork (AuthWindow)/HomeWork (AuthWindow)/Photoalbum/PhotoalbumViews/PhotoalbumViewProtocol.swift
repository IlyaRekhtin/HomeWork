//
//  PhotoalbumViewProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import Foundation

protocol PhotoalbumViewProtocol: AnyObject {
    var presenter: PhotoalbumPresenterProtocol? {get set}
    
    func update(with photos: [PhotoalbumViewModel])
    func setNameForNavigationBar(_ name: String)
}
