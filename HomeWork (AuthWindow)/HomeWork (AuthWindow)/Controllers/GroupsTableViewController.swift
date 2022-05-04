//
//  GroupsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

class GroupsTableViewController: UIViewController {
    
    lazy private var groups = DataManager.data.myGroups
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        configurationsForTableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configurationsForTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseID)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    private func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationItem.backButtonTitle = ""
        self.tabBarItem.tag = 1
    }
    
    @IBAction func searchActionButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "searchViewController") as? SearchGroupViewController else {return}
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalTransitionStyle = .crossDissolve
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true) {
            //todo
        }
        
    }
}
    // MARK: - Table view data source
    extension GroupsTableViewController: UITableViewDelegate, UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return groups.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseID, for: indexPath) as! GroupsTableViewCell
            cell.setCellSetup(for: groups[indexPath.row])
            cell.selectionStyle = .none
            cell.hiddenButtonAdd()
            return cell
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        }
        
    }
