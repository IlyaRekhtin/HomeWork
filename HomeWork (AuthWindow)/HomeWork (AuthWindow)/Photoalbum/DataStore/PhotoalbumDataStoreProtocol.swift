//
//  PhotoalbumDataStoreProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import Foundation

protocol PhotoalbumDataStoreProtocol {
    var userID: Int {get set}
    var userName: String {get set}
    func start(for user: Int, complition: @escaping ([Photo]?) -> ())
}
