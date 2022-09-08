//
//  PhotoalbumAssemblyProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import Foundation

protocol PhotoalbumAssemblyProtocol: AnyObject {
    func configure(with viewController: PhotoalbumViewController, _ userID: Int, _ userName: String)
}
