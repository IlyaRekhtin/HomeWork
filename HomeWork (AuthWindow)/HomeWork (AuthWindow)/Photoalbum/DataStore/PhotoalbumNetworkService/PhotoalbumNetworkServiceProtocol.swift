//
//  PhotoalbumNetworkServiceProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 08.09.2022.
//

import Foundation
import PromiseKit

protocol PhotoalbumNetworkServiceProtocol {
    func getURL(for userID: Int) -> Promise<URL>
    func fetchData(_ url: URL) -> Promise<Data>
    func parsedData(_ data: Data) -> Promise<[Photo]>
}
