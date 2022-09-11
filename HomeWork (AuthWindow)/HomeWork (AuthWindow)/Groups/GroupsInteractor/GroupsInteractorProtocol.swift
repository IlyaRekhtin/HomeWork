//
//  GroupsInteractorProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import UIKit

protocol GroupsInteractorProtocol: AnyObject {
    var presenter: GroupsPresenterProtocol? {get set}
    var dataStore: GroupsDataStoreProtocol? {get set}
    func getGroups()
    func getPhoto(url: String, complition: @escaping (UIImage?) -> ())
}
