//
//  GroupsDatabase.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 10.09.2022.
//

import Foundation
import RealmSwift

final class GroupsDatabaseService: GroupsDatabaseProtocol {
    
    func readFromDatabase() -> Results<Group> {
            let realm = try! Realm()
            let items = realm.objects(Group.self)
            return items
    }
    
    func writeToDatabase(_ items: [Group]?) {
        guard let groups = items else {return}
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(groups, update: .modified)
                }
            } catch {
                print(error.localizedDescription)
            }
    }
    
    func deleteFromDatabase(_ item: Group) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
}
