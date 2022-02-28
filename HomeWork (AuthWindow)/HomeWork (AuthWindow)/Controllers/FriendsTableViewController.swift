//
//  FrandsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let friendFotoVC = segue.destination as? FriendFotoCollectionViewController else {return}
        let user = DataBase.data.friends[tableView.indexPathForSelectedRow!.row]
        friendFotoVC.user = user
    }
    
    private func configNavigationController(){
//        let titleForNavBar: UILabel = {
//            let lable = UILabel()
//            lable.text = "Друзья"
//            lable.font = UIFont(name: "Apple Color Emoji", size: 22)
//            lable.textColor = .systemGreen
//            return lable
//        }()
//        self.navigationItem.titleView = titleForNavBar
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func exitForAccount(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "password")
        dismiss(animated: true)
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBase.data.friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseID, for: indexPath) as! FriendsTableViewCell
        let user = DataBase.data.friends[indexPath.row]
        cell.getRowForFriendsVC(for: user)
        cell.selectionStyle = .none
        tableView.rowHeight = cell.getimageSize().height + 10
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToFoto", sender: nil)
    }
}
