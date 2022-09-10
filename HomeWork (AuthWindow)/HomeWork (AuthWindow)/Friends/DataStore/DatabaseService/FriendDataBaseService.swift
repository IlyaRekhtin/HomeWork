//
//  DataBaseService.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 07.09.2022.
//

import PromiseKit
import RealmSwift

final class FriendDatabaseService: FriendDatabaseProtocol {
    
    func readFromDatabase() ->Results<Friend> {
            let realm = try! Realm()
            let items = realm.objects(Friend.self)
            return items
    }
    
    
    func writeToDatabase(_ items: [Friend]?) {
        guard let friends = items else {return}
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(friends, update: .modified)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    
    func deleteFromDatabase(_ item: Friend) {
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
