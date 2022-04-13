//
//  SearchGroupTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit
import SnapKit

class SearchGroupViewController: UIViewController {
    
    private var tableView: UITableView!
    private var groups = DataManager.data.allGroups
    private var searchBar: UISearchBar!
    private var searchResultArray = Set<Person>()
    private var tapRecognizer: UITapGestureRecognizer!
    
    private var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCancekButton()
        configSearchBar()
        configTableView()
        configNavigationBar()
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapForHideKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveLinear) {
            self.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 120, height: 30)
            
            self.cancelButton.layer.opacity = 1
            
        } completion: { _ in
            self.searchBar.becomeFirstResponder()
        }

    }
    
    private func configCancekButton() {
        cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 50), primaryAction: UIAction(handler: { _ in
            self.dismiss(animated: true)
        }))
        cancelButton.configuration = .plain()
        cancelButton.configuration?.title = "Отменить"
        cancelButton.configuration?.baseForegroundColor = .systemGreen
        cancelButton.configuration?.titleAlignment = .center
        cancelButton.titleLabel?.font = UIFont(name: "Times New Roman", size: 17)
        cancelButton.layer.opacity = 0
        
    }
    
    private func configSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0 , height: 30))
        searchBar.showsCancelButton = false
        searchBar.tintColor = .systemGreen
        searchBar.placeholder = "Search"
        searchBar.isSearchResultsButtonSelected = true
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
        
    }

    private func configTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configNavigationBar() {
        let searchBarLeftButton = UIBarButtonItem(customView: self.searchBar)
        let cancelLeftBarButton = UIBarButtonItem(customView: self.cancelButton)
        self.navigationItem.leftBarButtonItems = [searchBarLeftButton, cancelLeftBarButton]
        
    }

    @objc private func cancelButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func tapForHideKeyboard() {
        searchBar.resignFirstResponder()
    }
}
    // MARK: - Table view data source
extension SearchGroupViewController: UITableViewDataSource, UITableViewDelegate {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBar.searchTextField.text != "" {
            return searchResultArray.count
        } else {
            return DataManager.data.allGroups.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseID, for: indexPath) as! GroupsTableViewCell
        let groupArray = searchBar.searchTextField.text != "" ? Array(searchResultArray) : groups
        let group = groupArray[indexPath.row]
        cell.setCellSetup(for: group)
     
        cell.selectionStyle = .none
       

        return cell
    }
}

extension SearchGroupViewController: UISearchBarDelegate, UISearchTextFieldDelegate {
    
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
    
}
