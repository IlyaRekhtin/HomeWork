//
//  AddedGroups.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 29.05.2022.
//

//import Firebase
//
//final class AddedGroup {
//    let name: String
//    let id: Int
//    
//    let ref: DatabaseReference?
//    
//    init(name: String, id: Int) {
//        self.name = name
//        self.id = id
//        self.ref = nil
//    }
//    
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: Any],
//            let id = value["id"] as? Int,
//            let name = value["name"] as? String else {
//            return nil
//        }
//        self.ref = snapshot.ref
//        self.id = id
//        self.name = name
//    }
//    
//    func toAnyObject() -> [String: Any] {
//       return [
//       "name": name,
//       "id": id
//       ]
//    }
//    
//}
