//
//  SearchGroupTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit
import SnapKit
import RealmSwift


class SearchGroupViewController: UIViewController {
    
    private let service = SearchGroupsService()
    private let factory = GroupViewModelFactory()
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var groupViewModels = [GroupViewModel]()
    private var searchResultArray = [Group]()
    private var tapRecognizer: UITapGestureRecognizer!
    
    
    private var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSearchBarController()
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapForHideKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateSearchBar()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        do {
            let realm = try Realm()
            try realm.write {
                let objects = realm.objects(Group.self).filter("isMember == 0")
                realm.delete(objects)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
   

    //    @objc private func cancelButtonAction() {
    //        dismiss(animated: true)
    //    }
}
//MARK: - private
private extension SearchGroupViewController {
    func configSearchBarController() {
        configTableView()
        configCancelButton()
        configSearchBar()
        configNavigationBar()
    }
    
    func configTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        
        makeConstraints()
    }
    
    func configNavigationBar() {
        let searchBarLeftButton = UIBarButtonItem(customView: self.searchBar)
        let cancelLeftBarButton = UIBarButtonItem(customView: self.cancelButton)
        self.navigationItem.leftBarButtonItems = [searchBarLeftButton, cancelLeftBarButton]
    }
    
    func makeConstraints() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configCancelButton() {
        cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 50), primaryAction: UIAction(handler: { _ in
            self.dismiss(animated: true)
        }))
        cancelButton.configuration = .plain()
        cancelButton.configuration?.title = "Отменить"
        cancelButton.configuration?.baseForegroundColor = .systemGreen
        cancelButton.configuration?.titleAlignment = .center
        cancelButton.titleLabel?.font = UIFont.mainTextFont
        cancelButton.layer.opacity = 0
    }
    
    func configSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0 , height: 30))
        searchBar.showsCancelButton = false
        searchBar.tintColor = .systemGreen
        searchBar.placeholder = "Search"
        searchBar.isSearchResultsButtonSelected = true
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
    }
    
    @objc func tapForHideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func animateSearchBar() {
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
}

// MARK: - Table view data source
extension SearchGroupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseID, for: indexPath) as! GroupsTableViewCell
        let group = groupViewModels[indexPath.row]
        cell.setCellSetup(for: group)
        cell.selectionStyle = .none
        return cell
    }
}

extension SearchGroupViewController: UISearchBarDelegate, UISearchTextFieldDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        service.getGroupsSearch(searchText: searchText) {[weak self] groups in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.searchResultArray = groups
                self.groupViewModels = self.factory.constructViewModel(for: groups)
                self.tableView.reloadData()
            }
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
}
