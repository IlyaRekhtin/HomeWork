//
//  PhotoalbumDataStoreProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit

protocol PhotoalbumDataStoreProtocol {
    var userID: Int {get set}
    var userName: String {get set}
    var networkService: PhotoalbumNetworkServiceProtocol {get}
    var cacheService: PhotoalbumCacheService {get}
    func start(for user: Int, complition: @escaping ([Photo]) -> ())
}
