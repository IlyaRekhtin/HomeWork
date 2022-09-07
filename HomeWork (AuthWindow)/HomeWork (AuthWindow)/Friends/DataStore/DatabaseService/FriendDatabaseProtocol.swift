//
//  FriendDatabaseProtocol.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 07.09.2022.
//

import Foundation
import RealmSwift

protocol FriendDatabaseProtocol {
    func readFromDatabase() -> Results<Friend>
    func writeToDatabase(_ items: [Friend])
    func deleteFromDatabase(_ item: Friend)
}
