//
//  PhotoalbumCacheServiceProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import UIKit
import PromiseKit


protocol PhotoalbumCacheServiceProtocol: AnyObject {
    func getPhoto(by url: String) -> Promise<UIImage>
}
