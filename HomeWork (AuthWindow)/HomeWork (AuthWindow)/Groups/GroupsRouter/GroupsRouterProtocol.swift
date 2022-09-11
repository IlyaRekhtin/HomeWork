//
//  GroupsRouterProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import UIKit

protocol GroupsRouterProtocol {
    typealias EntryPoint = GroupsViewProtocol & UIViewController
    var entryPoint:  EntryPoint? {get}
    
    static func start() -> GroupsRouterProtocol
}
