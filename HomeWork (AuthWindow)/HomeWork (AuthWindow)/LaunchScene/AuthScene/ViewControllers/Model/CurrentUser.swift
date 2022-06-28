//
//  CurrentUser.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.05.2022.
//

import Firebase

final class CurrentUser {
    let id: Int
    
    let ref: DatabaseReference?
    
    init(id: Int) {
        self.id = id
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int
        else {
            return nil
        }
        self.ref = snapshot.ref
        self.id = id
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "id": id
        ]
    }
    
}
