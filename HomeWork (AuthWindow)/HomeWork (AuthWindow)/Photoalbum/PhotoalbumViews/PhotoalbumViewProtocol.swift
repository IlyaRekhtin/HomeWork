//
//  PhotoalbumViewProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit

protocol PhotoalbumViewProtocol: AnyObject {
    var presenter: PhotoalbumPresenterProtocol? {get set}
    var collectionView: UICollectionView {get}
    
    func update(with photos: [String])
    func setNameForNavigationBar(_ name: String)
}