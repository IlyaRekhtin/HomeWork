//
//  NewsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//


import UIKit
import RealmSwift

class NewsfeedTableViewController: UITableViewController {
    
    private var news: Results<News>? {
        DataManager.data.readFromDatabase(News.self)
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configNavigationController()
        tableView.register(NewsfeedTableViewCell.self, forCellReuseIdentifier: NewsfeedTableViewCell.reuseID)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedTableViewCell.reuseID, for: indexPath) as! NewsfeedTableViewCell
        if let news = news?[indexPath.row] {
        cell.configurationCell(with: news)
        cell.selectionStyle = .none
        }
        return cell
    }
}

//MARK: - private
private extension NewsfeedTableViewController {
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
