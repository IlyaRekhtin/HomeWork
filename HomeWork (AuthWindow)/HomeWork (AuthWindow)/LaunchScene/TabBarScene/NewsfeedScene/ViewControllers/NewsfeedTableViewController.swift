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
    
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configNavigationController()
        tableView.register(NewsfeedTableViewCell.self, forCellReuseIdentifier: NewsfeedTableViewCell.reuseID)
        addNotificationToken()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_ :)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        
    }
    
    private func  addNotificationToken() {
        self.token = news?.observe { [weak self] result in
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
