//
//  PhotoalbumDataStoreProxy.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import Foundation

final class PhotoalbumDataStoreProxy: PhotoalbumDataStoreProtocol {
   
    
    
    var userID: Int = 0
    var userName: String = ""
    private var service: PhotoalbumDataStoreProtocol!
    
    init(_ service: PhotoalbumDataStoreProtocol) {
        self.service = service
    }
    
    func start(for user: Int, complition: ([Photo]?) -> ()) {
        log(.photosGetAll)
        
    }
    
}
