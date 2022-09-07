//
//  GroupServiceProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 04.09.2022.
//

import Foundation
import PromiseKit

protocol GroupServiceProtocol {
    func getURL() -> Promise<URL>
    func fetchData(_ url: URL) -> Promise<Data>
    func parsedData(_ data: Data) -> Promise<[Group]>
    func writeGroupsToDatabase(_ groups: [Group])
}

