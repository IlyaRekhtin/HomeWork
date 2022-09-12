//
//  PhotoViewerDataStoreProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import Foundation

protocol PhotoViewerDataStoreProtocol: AnyObject {
    var cacheService: PhotoalbumCacheService {get set}
}
