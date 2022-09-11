//
//  GroupsCacheServiceProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import UIKit
import PromiseKit

protocol GroupsCacheServiceProtocol: AnyObject {
    func getPhoto(by url: String) -> Promise<UIImage?>
}
