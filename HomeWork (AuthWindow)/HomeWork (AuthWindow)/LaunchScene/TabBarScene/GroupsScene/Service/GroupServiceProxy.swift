//
//  GroupServiceProxy.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 04.09.2022.
//

import Foundation
import PromiseKit

final class GroupServiceProxy: GroupServiceProtocol {
    
    private var service: GroupsService
    
    init(_ service: GroupsService) {
        self.service = service
    }
    
    func fetchData(_ url: URL) -> Promise<Data> {
        log(.groupsGet)
      return service.fetchData(url)
    }
    func getURL() -> Promise<URL> {
        service.getURL()
    }
    
    func parsedData(_ data: Data) -> Promise<[Group]> {
        service.parsedData(data)
    }
    
    func writeGroupsToDatabase(_ groups: [Group]) {
        service.writeGroupsToDatabase(groups)
    }
}
