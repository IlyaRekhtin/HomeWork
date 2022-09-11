//
//  GroupsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit
import RealmSwift


class GroupsViewController: UIViewController, GroupsViewProtocol {
    
    var presenter: GroupsPresenterProtocol?
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.reuseID)
        return table
    }()
    private var groupViewModels = [GroupViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        configNavigationController()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.compactAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.standardAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationItem.backButtonTitle = ""
        self.tabBarItem.tag = 1
    }
    
    func update(with groups: [GroupViewModel]) {
        DispatchQueue.main.async {
            self.groupViewModels = groups
            self.tableView.reloadData()
        }
    }
    
    func update(with error: String) {
        
    }

    @IBAction func searchActionButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "searchViewController") as? SearchGroupViewController else {return}
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalTransitionStyle = .crossDissolve
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
// MARK: - Table view data source
extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.reuseID, for: indexPath) as! GroupsTableViewCell
        let group =  groupViewModels[indexPath.row]
        self.presenter?.getPhoto(url: group.avatar, complition: {fetchImage in
            guard let image = fetchImage else {return}
            cell.groupImage.setImage(image)
        })
        cell.setCellSetup(for: group)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
}








//    private var groups: Results<Group>? {
//        let objects = DataManager.data.readFromDatabase(Group.self).filter("isMember == 1")
//        self.groupViewModels = factory.constructViewModel(for: Array(objects))
//        return objects
//    }
    
//    private var token: NotificationToken?




//    private func  addNotificationToken() {
//        self.token = groups?.observe { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .initial(_):
//                print("init")
//            case .update(_,
//                         deletions: let deletions,
//                         insertions: let insertions,
//                         modifications: let modifications):
//                let deletionsIndexpath = deletions.map { IndexPath(row: $0, section: 0) }
//                let insertionsIndexpath = insertions.map { IndexPath(row: $0, section: 0) }
//                let modificationsIndexpath = modifications.map { IndexPath(row: $0, section: 0) }
//
//                DispatchQueue.main.async {
//                    self.tableView.beginUpdates()
//                    self.tableView.deleteRows(at: deletionsIndexpath, with: .automatic)
//                    self.tableView.insertRows(at: insertionsIndexpath, with: .automatic)
//                    self.tableView.reloadRows(at: modificationsIndexpath, with: .automatic)
//                    self.tableView.endUpdates()
//                }
//            case .error(let error):
//                print("\(error)")
//            }
//        }
//    }


//        guard let group = groups?[indexPath.row] else {return}
//        /// удалям группу на сервере
//        let buttonService = ButtonForAddGroupsService()
//        buttonService.groupNetwork(group.id, .leaveGroup)
//        /// удаляем из базы данных realm
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.delete(group)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
