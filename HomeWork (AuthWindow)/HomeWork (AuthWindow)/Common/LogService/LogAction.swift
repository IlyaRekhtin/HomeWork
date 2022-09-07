//
//  LogAction.swift
//  XO-game
//
//  Created by Alexander Rubtsov on 12.08.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

func log(_ action: Api.BaseURL.ApiMethod ) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}
