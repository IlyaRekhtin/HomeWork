//
//  GroupsDatabaseProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import Foundation
import RealmSwift

protocol GroupsDatabaseProtocol: AnyObject {
    func readFromDatabase() ->Results<Group>
    func writeToDatabase(_ items: [Group]?)
    func deleteFromDatabase(_ item: Group)
}
