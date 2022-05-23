//
//  GroupsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UIViewController {
    
    private var groups: Results<Group>? {
        DataManager.data.readFromDatabase(Group.self)
    }
    
    private var token: NotificationToken?
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        configurationsForTableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    private func configurationsForTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseID)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        addNotificationToken()
    }
    
    private func  addNotificationToken() {
        self.token = groups?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(_):
                self.tableView.reloadData()
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                let deletionsIndexpath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexpath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexpath = modifications.map { IndexPath(row: $0, section: 0) }
                
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: deletionsIndexpath, with: .automatic)
                    self.tableView.insertRows(at: insertionsIndexpath, with: .automatic)
                    self.tableView.reloadRows(at: modificationsIndexpath, with: .automatic)
                    self.tableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
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
        return groups?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseID, for: indexPath) as! GroupsTableViewCell
        if let groups = self.groups {
            cell.setCellSetup(for: groups[indexPath.row])
        }
        cell.selectionStyle = .none
//        cell.hiddenButtonAdd()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let group = groups?[indexPath.row] else {return}
        /// удаляем из базы данных
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(group)
            }
            
            // TODO удалить группу на сервере
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
