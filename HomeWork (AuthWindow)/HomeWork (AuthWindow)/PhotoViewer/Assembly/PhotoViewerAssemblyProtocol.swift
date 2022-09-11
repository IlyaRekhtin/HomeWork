//
//  PhotoViewerAssemblyProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import Foundation

protocol PhotoViewerAssemblyProtocol: AnyObject {
    func configure(with viewController: PhotoViewerProtocol, _ photoAlbum: [String], _ index: Int)
}
