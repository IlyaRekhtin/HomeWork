//
//  WriteDataToDatabaseOperation.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 17.06.2022.
//

import Foundation
import RealmSwift

class WriteDataToDatabaseOperation<T:Object>: AsyncOperation {
    
    
    override func main() {
        saveObjectToDatabase()
    }
    
    private func saveObjectToDatabase(){
        guard let parseData = dependencies.first as? ParseDataToFriendsOperation else {return}
        do {
            let friends = parseData.friends
            let realm = try Realm()
            try realm.write {
                realm.add(friends, update: .modified)
                self.state = .finished
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
