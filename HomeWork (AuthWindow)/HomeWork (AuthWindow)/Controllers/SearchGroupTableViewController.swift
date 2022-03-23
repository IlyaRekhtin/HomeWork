//
//  SearchGroupTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit
import SnapKit

class SearchGroupTableViewController: UITableViewController, UISearchBarDelegate, UITextFieldDelegate {

    private var groups = DataBase.data.allGroups
    private var searchBar: UISearchBar!
    private var searchResultArray = Set<Person>()
    private var tapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSearchBar()
        configNavigationController()
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseID)
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapForHideKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    private func configSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        searchBar.searchTextField.delegate = self
        searchBar.showsCancelButton = false
        searchBar.tintColor = .systemGreen
        searchBar.placeholder = "Search"
        searchBar.isSearchResultsButtonSelected = true
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }
    
    private func configNavigationController() {
        navigationItem.backButtonTitle = ""
    }

    @objc private func tapForHideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultArray.removeAll()
        
        for group in groups {
            let name = group.name
            if name.contains(searchText) {
                searchResultArray.insert(group)
                self.tableView.reloadData()
            }
        }
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBar.searchTextField.text != "" {
            return searchResultArray.count
        } else {
            return DataBase.data.allGroups.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseID, for: indexPath) as! GroupsTableViewCell
        let groupArray = searchBar.searchTextField.text != "" ? Array(searchResultArray) : groups
        let group = groupArray[indexPath.row]
        cell.setCellSetup(for: group)
     
        cell.selectionStyle = .none
       
        tableView.rowHeight = cell.getImageSize().height + 10

        return cell
    }
    

}
