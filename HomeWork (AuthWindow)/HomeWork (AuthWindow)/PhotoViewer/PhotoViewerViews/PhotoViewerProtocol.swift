//
//  PhotoViewerProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import UIKit

protocol PhotoViewerProtocol: AnyObject {
    var presenter: PhotoViewerPresenterProtocol? {get set}
    var assembly: PhotoViewerAssemblyProtocol {get set}
    var firstImageView: UIImageView {get set}
    var currentIndexPuthPhoto: Int {get set}
    var photoAlbum: [Likeble & Reposteble] {get set}
    
}
