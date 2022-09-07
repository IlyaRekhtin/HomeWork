//
//  PhotoServiceProxy.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 04.09.2022.
//

import Foundation

final class PhotoServiceProxy: PhotoServiceProtocol {
    
    private var service: PhotoAlbumService
    
    init(_ service: PhotoAlbumService) {
        self.service = service
    }
    
    func getPhotos(for userID: Int, complition: @escaping (Photos) -> ()) {
        log(.photosGetAll)
        self.service.getPhotos(for: userID) { photo in
            complition(photo)
        }
    }
    
    
}
