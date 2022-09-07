//
//  FrandsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit
import SnapKit
import RealmSwift

class FriendsViewController: UIViewController {
    
    private let service = FriendsService()
    private let factory = FriendViewModelFactory()
    
    private var photoCachesService: PhotoCachesService!
    
    private var tableView: UITableView!
    private var token: NotificationToken?
    private var realmFriends: Results<Friend>? {
        let objects = self.service.readFriendsFromDatabase().sorted(byKeyPath: "firstName", ascending: true)
        self.friends = factory.constructViewModel(for: Array(objects))
        return objects
    }
    private var friends = [FriendViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationsForTableView()
        makeConstraints()
        addNotificationToken()
        service.fetchFriendsFromNetworkAndSaveToDatabase()
        self.photoCachesService = PhotoCachesService(tableView: self.tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationController()
    }
    
    deinit {
        token?.invalidate()
    }
}
//MARK: - private
private extension FriendsViewController {
    func configurationsForTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseID)
    }
    //MARK: - NavBarSettings
    func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func exitForAccount(_ sender: Any) {
        //TODO
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - настройка ячейки
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseID, for: indexPath) as! FriendsTableViewCell
        let friend = friends[indexPath.row]
        cell.configCell(for: friend)
        cell.avatar.userPhoto.image = photoCachesService.getPhoto(at: indexPath, by: friend.avatar)
        cell.selectionStyle = .none
        tableView.rowHeight = cell.getimageSize().height + 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FriendFotoCollectionViewController") as? PhotoAlbumVC else {return}
        let friend = friends[tableView.indexPathForSelectedRow!.row]
        vc.userId = friend.id
        vc.name = friend.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - make constraints
private extension FriendsViewController {
    func makeConstraints(){
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: - Notification token
private extension FriendsViewController {
    func  addNotificationToken() {
        self.token = realmFriends?.observe { [weak self] result in
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
}
