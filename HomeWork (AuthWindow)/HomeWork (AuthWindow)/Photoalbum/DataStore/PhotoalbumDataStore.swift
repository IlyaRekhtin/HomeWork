//
//  PhotoalbumDataStore.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit
import PromiseKit
import SwiftUI

final class PhotoalbumDataStore: PhotoalbumDataStoreProtocol {
    
    var networkService: PhotoalbumNetworkServiceProtocol = PhotoalbumNetworkService()
    var cacheService = PhotoalbumCacheService()
    var userID: Int = 0
    var userName: String = ""
    
    func start(for user: Int, complition: @escaping ([String]) -> ()) {
        firstly {
            networkService.getURL(for: user)
        }.then(on: .global()) { url in
            self.networkService.fetchData(url)
        }.then(on: .global()) { data in
            self.networkService.parsedData(data)
        }.then(on: .global()) { photos in
            self.networkService.getCurrentUrl(photos)
        }.done { urlsString in
           complition(urlsString)
        }.catch { error in
            print(error.localizedDescription)
        }
        
    }
}

