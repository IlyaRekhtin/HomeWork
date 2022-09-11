//
//  FriendsView.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 06.09.2022.
//

import UIKit

final class FriendsViewController: UIViewController, FriendsViewProtocol {
    
    var presenter: FriendsPresenterProtocol?
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(FriendsTableViewCell.self,
                       forCellReuseIdentifier: FriendsTableViewCell.reuseID)
        
        table.isHidden = true
        return table
    }()
    
    private var friendViewModels = [FriendViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBlue
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    deinit {
        print("deinit friendVC")
    }
    
    private func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.compactAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.standardAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.mainNavigationControllerAppearance()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    func update(with friends: [FriendViewModel]) {
        DispatchQueue.main.async {
            self.friendViewModels = friends
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - настройка ячейки
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseID, for: indexPath) as! FriendsTableViewCell
        let item = friendViewModels[indexPath.row]
        cell.configCell(for: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = self.friendViewModels[indexPath.row].id
        let name = self.friendViewModels[indexPath.row].name
        presenter?.cellDidSelect(for: userId, with: name)
    }
}


