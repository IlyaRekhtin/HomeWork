//
//  FriendsRouterProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import Foundation
import UIKit

typealias EntryPoint = FriendsViewProtocol & UIViewController

protocol FriendsRouterProtocol: AnyObject {
    var entryPoint:  EntryPoint? {get}
    
    static func start() -> FriendsRouterProtocol
}
