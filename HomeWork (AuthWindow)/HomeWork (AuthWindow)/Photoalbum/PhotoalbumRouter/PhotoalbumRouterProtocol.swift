//
//  PhotoalbumRouterProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit

protocol PhotoalbumRouterProtocol: AnyObject {
    typealias EntryPoint = PhotoalbumViewProtocol & UIViewController
    var entryPoint:  EntryPoint? {get}
    
    func presentPhotoViewer( _ photoalbum: [Likeble & Reposteble], _ index: Int)
}

