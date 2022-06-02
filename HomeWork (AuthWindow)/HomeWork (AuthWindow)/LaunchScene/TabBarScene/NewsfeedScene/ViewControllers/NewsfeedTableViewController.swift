//
//  NewsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//


import UIKit
import RealmSwift

class NewsfeedTableViewController: UITableViewController {
    
    private let service = NewsfeedService()
    var news = DataManager.data.news
    var users = DataManager.data.users
    var groups = DataManager.data.groups
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        tableView.register(HeaderNewsCell.self, forCellReuseIdentifier: HeaderNewsCell.reuseID)
        tableView.register(FooterNewsCell.self, forCellReuseIdentifier: FooterNewsCell.reuseID)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_ :)))
        self.view.addGestureRecognizer(tap)
        print(news.count)
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderNewsCell.reuseID, for: indexPath) as! HeaderNewsCell
        let footerCell = tableView.dequeueReusableCell(withIdentifier: FooterNewsCell.reuseID, for: indexPath) as! FooterNewsCell
        
        let currentNews = news[indexPath.section]
        let itemForHeader = currentNews.sourceID < 0 ? groups.filter{-$0.id == currentNews.sourceID}.first : users.filter{$0.id == currentNews.sourceID}.first
        switch indexPath.row {
        case 0:
            currentNews.sourceID < 0 ? headerCell.configCellForGroup(itemForHeader as! Group, date: currentNews.date) : headerCell.configCellForFriend(itemForHeader as! User, date: currentNews.date)
            return headerCell
        case 1:
            footerCell.configCellForFooter(news: currentNews)
            footerCell.backgroundColor = .brown
            return footerCell
        default:
            footerCell.configCellForFooter(news: currentNews)
            return footerCell
        }
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
