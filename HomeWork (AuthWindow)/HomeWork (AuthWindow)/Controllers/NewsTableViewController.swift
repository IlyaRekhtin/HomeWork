//
//  NewsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private var newsfeed = DataManager.data.newsfeed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationController()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsfeed.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as! NewsTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .brown
        return cell
    }
}

//MARK: - private
private extension NewsTableViewController {
    func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
}
