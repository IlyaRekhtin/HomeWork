//
//  ReadDataFromDatabase.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.06.2022.
//

import Foundation
import RealmSwift

class ReadDataFromDatabase<T:Object>: AsyncOperation {
    
    var item: T.Type
    var results: Results<T>?
    
    init(_ item: T.Type) {
        self.item = item
    }
    
    override func main() {
        results = readFromDatabase(item)
    }
    
    func readFromDatabase<T:Object>(_ item: T.Type) -> Results<T> {
        
        let realm = try! Realm()
        let items = realm.objects(T.self)
        return items
    }
}
