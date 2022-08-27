//
//  Table.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 24.06.2022.
//

import Foundation
import UIKit

final class Table: DataReloadable {
   
    let table: UITableView
    
    init(table: UITableView) {
        self.table = table
    }
    
    func reloadRow(at indexPath: IndexPath) {
        self.table.reloadRows(at: [indexPath], with: .none)
    }
    
}
