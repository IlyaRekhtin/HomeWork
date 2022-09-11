//
//  GroupsNetworkServiceProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import Foundation
import PromiseKit

protocol GroupsNetworkServiceProtocol: AnyObject {
    func getURL() -> Promise<URL>
    func fetchData(_ url: URL) -> Promise<Data>
    func parsedData(_ data: Data) -> Promise<[Group]>
}
