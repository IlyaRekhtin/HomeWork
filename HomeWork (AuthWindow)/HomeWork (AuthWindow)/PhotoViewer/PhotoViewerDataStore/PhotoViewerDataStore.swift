//
//  PhotoViewerDataStore.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import Foundation

final class PhotoViewerDataStore: PhotoViewerDataStoreProtocol {
    var cacheService = PhotoalbumCacheService()
}
