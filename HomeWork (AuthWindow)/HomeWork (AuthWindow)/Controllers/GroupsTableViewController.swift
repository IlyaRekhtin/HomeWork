//
//  GroupsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    private var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseID)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groups = Array(DataBase.data.myGroups)
        tableView.reloadData()
    }
    
    private func configNavigationController(){
        let titleForNavBar: UILabel = {
            let lable = UILabel()
            lable.text = "My groups"
            lable.font = UIFont(name: "Apple Color Emoji", size: 22)
            lable.textColor = .white
            return lable
        }()
        self.navigationItem.titleView = titleForNavBar
        self.tabBarItem.tag = 1
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBase.data.myGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseID, for: indexPath) as! GroupsTableViewCell
        cell.setCellSetup(for: groups[indexPath.row])
        cell.selectionStyle = .none
        tableView.rowHeight = cell.getImageSize().height + 10
        cell.hiddenButtonAdd()
        return cell
    }
    
    @IBAction func searchActionButton(_ sender: Any) {
        performSegue(withIdentifier: "goToSearch", sender: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataBase.data.myGroups.remove(groups[indexPath.row])
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
         
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}