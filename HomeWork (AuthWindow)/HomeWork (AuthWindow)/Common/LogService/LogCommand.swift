//
//  LogCommand.swift
//  XO-game
//
//  Created by Alexander Rubtsov on 12.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class LogCommand {
    let action: Api.BaseURL.ApiMethod
    
    var logMessage: String {
        "Выполнен запрос сетевого метода - \(action)"
    }
    
    init(action: Api.BaseURL.ApiMethod) {
        self.action = action
    }
}
