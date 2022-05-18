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
    
    private var tableView: UITableView!
    
    private var nameSearchControl: NameSearchControl!
    
    private var friends: Results<Friend>?{
        DataManager.data.readFromDatabase(Friend.self)
    }
    
    private var firstLettersOfNames = [String]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLettersOfNames = DataManager.data.getFirstLettersOfTheNameList(in: friends!)
        configurationsForTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationController()
    }
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - настройка секций
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return firstLettersOfNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(firstLettersOfNames[section])
    }
    
    
    //MARK: - настройка ячейки
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let friends = self.friends else {return 0}
        return filterUsersForSection(friends, firstLettersOfNames[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseID, for: indexPath) as! FriendsTableViewCell
        let firstNameLetter = firstLettersOfNames[indexPath.section]
        guard let friends = self.friends else {return cell}
        let usersForSection = filterUsersForSection(friends, firstNameLetter)
        let friend = usersForSection[indexPath.row]
        cell.configCell(for: friend)
        cell.selectionStyle = .none
        tableView.rowHeight = cell.getimageSize().height + 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FriendFotoCollectionViewController") as? FriendFotoCollectionViewController else {return}
        let firstNameLetter = firstLettersOfNames[tableView.indexPathForSelectedRow!.section]
        guard let friends = self.friends else {return}
        let currentFriends = filterUsersForSection(friends, firstNameLetter)
        let friend = currentFriends[tableView.indexPathForSelectedRow!.row]
        vc.userId = friend.id
        vc.firstName = friend.firstName
        vc.lastName = friend.lastName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - вспомогательные функции
    
    private func loadDataFromRealmBD(){
        
    }
    
    /// Распределение пользователей по с екциям
    /// - Parameters:
    ///   - friends: массив пользователей
    ///   - letterForFilter: Инициал имени
    /// - Returns: массив полдьзователей с указанным инициалом
    private func filterUsersForSection(_ friends: Results<Friend>, _ letterForFilter: String) -> Results<Friend> {
        let arrayUsersForSection = friends.where {
            $0.firstName.starts(with: letterForFilter)
        }
        return arrayUsersForSection
    }
}
private extension FriendsViewController {
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
    
    func configurationsForTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseID)
        
        configurationForNameSearchControl()

        setConstraints()
    }
    
    func configurationForNameSearchControl() {
        nameSearchControl = NameSearchControl(frame: CGRect(x: 0, y: 0, width: 40, height: 200))
        
        createLableForNameSearchControl(firstLettersOfNames)
        nameSearchControl.addButtonsForControl(for: nameSearchControl.letters)
        
        nameSearchControl.addAction(UIAction(handler: { _ in
            self.tableView.scrollToRow(at: self.nameSearchControl.indexPuth!, at: .top, animated: true)
        }), for: .touchCancel)
    }
    
    func createLableForNameSearchControl(_ letters: [String]) {
        for letter in letters {
            let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            lable.text = letter
            lable.textColor = .systemGreen
            self.nameSearchControl.letters.append(lable)
        }
    }
    
    @IBAction func exitForAccount(_ sender: Any) {
        //TODO
    }
}

//MARK: - make constraints
private extension FriendsViewController {
    
    func setConstraints(){
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        self.view.addSubview(nameSearchControl)
        nameSearchControl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(100)
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
}
