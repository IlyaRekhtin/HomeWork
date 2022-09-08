//
//  FriendsRouterProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import UIKit


protocol FriendsRouterProtocol: AnyObject {
    typealias EntryPoint = FriendsViewProtocol & UIViewController
    var entryPoint:  EntryPoint? {get}
    
    static func start() -> FriendsRouterProtocol
    func goToPhotoalbumViewController(for userID: Int,_ name: String)
}
