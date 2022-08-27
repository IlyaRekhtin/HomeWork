//
//  City.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 03.06.2022.
//

import Foundation
import RealmSwift

class City: Object, Codable {
    @Persisted var title: String = ""
}
