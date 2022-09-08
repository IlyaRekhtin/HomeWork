//
//  PhotoalbumCacheServiceProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit

protocol PhotoalbumCacheServiceProtocol: AnyObject {
    func getPhoto(by url: String) -> UIImage?
}
