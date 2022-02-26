//
//  SearchGroupTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

class SearchGroupTableViewController: UITableViewController {

    private var groups = DataBase.data.allGroups
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseID)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBase.data.allGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseID, for: indexPath) as! GroupsTableViewCell
        cell.setCellSetup(for: groups[indexPath.row])
        cell.selectionStyle = .none
        let action = UIAction { _ in
            tableView.reloadRows(at: [indexPath], with: .left)
        }
        cell.addGroupButton.addAction(action, for: .touchDown)
       
        tableView.rowHeight = cell.getImageSize().height + 10

        return cell
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}