//
//  PhotoalbumDataStore.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import Foundation
import PromiseKit

final class PhotoalbumDataStore: PhotoalbumDataStoreProtocol {
    
    var networkService: PhotoalbumNetworkServiceProtocol = PhotoalbumNetworkService()
    var userID: Int = 0
    var userName: String = ""
    
    func start(for user: Int, complition: @escaping ([Photo]?) -> ()) {
        networkService.getURL(for: user)
            .then(on: .global(), networkService.fetchData(_:))
            .then(on: .global(), networkService.parsedData(_:))
            .done{ photos in
                complition(photos)
            }
            .catch { error in
                print(error.localizedDescription)
            }
    }
}
