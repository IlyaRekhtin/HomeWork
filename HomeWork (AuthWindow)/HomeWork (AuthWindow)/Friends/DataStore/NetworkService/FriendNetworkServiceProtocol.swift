//
//  NetworkServiceProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 07.09.2022.
//

import Foundation
import PromiseKit

protocol FriendNetworkServiceProtocol {
    func getURL() -> Promise<URL>
    func fetchData(_ url: URL) -> Promise<Data>
    func parsedData(_ data: Data) -> Promise<[Friend]>
}
