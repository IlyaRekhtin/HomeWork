//
//  PhotoServiceProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 04.09.2022.
//

import Foundation

protocol PhotoServiceProtocol {
    func getPhotos(for userID: Int, complition:@escaping (Photos) -> ())
}
