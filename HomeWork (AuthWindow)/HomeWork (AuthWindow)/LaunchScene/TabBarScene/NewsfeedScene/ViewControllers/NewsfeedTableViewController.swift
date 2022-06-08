//
//  NewsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//


import UIKit
import RealmSwift

class NewsfeedTableViewController: UITableViewController {
    private enum CellType: Int {
        case header = 0, text, body, footer
    }
    
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
        tableView.separatorStyle = .none
        tableView.register(HeaderNewsCell.self, forCellReuseIdentifier: HeaderNewsCell.reuseID)
        tableView.register(FooterNewsCell.self, forCellReuseIdentifier: FooterNewsCell.reuseID)
        tableView.register(TextNewsCell.self, forCellReuseIdentifier: TextNewsCell.reuseID)
        tableView.register(LinkNewsCell.self, forCellReuseIdentifier: LinkNewsCell.reuseID)
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
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderNewsCell.reuseID, for: indexPath) as! HeaderNewsCell
        let textCell = tableView.dequeueReusableCell(withIdentifier: TextNewsCell.reuseID, for: indexPath) as! TextNewsCell
        let linkCell = tableView.dequeueReusableCell(withIdentifier: LinkNewsCell.reuseID, for: indexPath) as! LinkNewsCell
        let footerCell = tableView.dequeueReusableCell(withIdentifier: FooterNewsCell.reuseID, for: indexPath) as! FooterNewsCell
        let currentNews = news[indexPath.section]
        let attachments = currentNews.attachments
        

        let cellType = CellType(rawValue: indexPath.row)
        switch cellType {
        case .header:
            if currentNews.sourceID < 0 {
                if let group = groups.filter({-$0.id == currentNews.sourceID}).first {
                    headerCell.configCellForGroup(group, for: currentNews)
                }
            } else {
                if let profile = users.filter({$0.id == currentNews.sourceID}).first {
                    headerCell.configCellForFriend(profile, for: currentNews)
                }
            }
            return headerCell
        case .text:
            textCell.configCell(for: currentNews.text ?? "нету")
            return textCell
        case .body:
            if attachments?.first?.type == .link, let link = attachments?.first?.link {
                linkCell.configCell(for: link)
            }
            return linkCell
        case .footer:
            footerCell.configCell(for: currentNews)
            return footerCell
        case .none:
            return footerCell
        }
    }
}

//MARK: - private
private extension NewsfeedTableViewController {
//    func sortAttachments<T>(_ attachments: [Attachment]?) -> [T] {
//        guard let attachments = attachments else {
//            return []
//        }
//        attachments.forEach { attachment in
//            <#code#>
//        }
//
//    }
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
