//
//  GroupsVIewProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import Foundation

protocol GroupsViewProtocol: AnyObject {
    var presenter: GroupsPresenterProtocol? {get set}
    
    func update(with groups: [GroupViewModel])
    func update(with error: String)
    
}
