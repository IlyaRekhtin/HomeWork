//
//  WriteDataToDatabaseOperation.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.06.2022.
//

import Foundation
import RealmSwift

class WriteDataToDatabaseOperation<T:Object>: Operation {
    
    var items: [T]
    
    init(_ items: [T]) {
        self.items = items
    }
    
    override func main() {
        saveObjectToDatabase(items)
    }
    
    private func saveObjectToDatabase<T:Object>(_ items: [T]){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(items, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
