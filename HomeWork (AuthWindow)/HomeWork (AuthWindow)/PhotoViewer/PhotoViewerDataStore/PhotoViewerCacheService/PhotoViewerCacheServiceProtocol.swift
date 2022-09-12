//
//  PhotoViewerCacheServiceProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 11.09.2022.
//

import UIKit
import PromiseKit

protocol PhotoViewerCacheServiceProtocol: AnyObject {
    func getPhoto(by url: String) -> Promise<UIImage>
}
