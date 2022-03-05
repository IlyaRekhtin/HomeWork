//
//  FrandsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit
import SnapKit

class FriendsViewController: UIViewController {
    
    private var tableview: UITableView!
    
    private var nameSearchControl: NameSearchControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigForTableView()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let friendFotoVC = segue.destination as? FriendFotoCollectionViewController else {return}
        let user = DataBase.data.friends[tableview.indexPathForSelectedRow!.row]
        friendFotoVC.user = user
    }

    private func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setConfigForTableView() {
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableview.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseID)
        self.view.addSubview(tableview)

        let actionForNameSearchControl = UIAction { _ in
           print("It's work!")
        }
        
        nameSearchControl = NameSearchControl(frame: CGRect(x: 0, y: 0, width: 30, height: 200), primaryAction: actionForNameSearchControl)
        self.view.addSubview(nameSearchControl)
        
        
        tableview.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            
        }
        
        nameSearchControl.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin)
            make.trailing.equalToSuperview()
            
        }
        
        
    }
    
    @IBAction func exitForAccount(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "sizeForLayoutForFotoGallary")
        dismiss(animated: true)
    }

}
    // MARK: - Table view data source
    extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBase.data.friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseID, for: indexPath) as! FriendsTableViewCell
        let user = DataBase.data.friends[indexPath.row]
        cell.getRowForFriendsVC(for: user)
        cell.selectionStyle = .none
        tableView.rowHeight = cell.getimageSize().height + 10
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToFoto", sender: nil)
    }

}
