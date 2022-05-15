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
    
    private var firstLetterOfNameFriends = [String]()
    
    override func loadView() {
        super.loadView()
        loadDataFromBD()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return firstLetterOfNameFriends.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(firstLetterOfNameFriends[section])
    }
    
    
    //MARK: - настройка ячейки
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterUsersForSection(DataManager.data.myFriends, Character(firstLetterOfNameFriends[section])).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseID, for: indexPath) as! FriendsTableViewCell
        let firstNameLetter = Character(firstLetterOfNameFriends[indexPath.section])
        let usersForSection = filterUsersForSection(DataManager.data.myFriends, firstNameLetter)
        let friend = usersForSection[indexPath.row]
        cell.configCell(for: friend)
        cell.selectionStyle = .none
        tableView.rowHeight = cell.getimageSize().height + 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FriendFotoCollectionViewController") as? FriendFotoCollectionViewController else {return}
        let firstNameLetter = Character(firstLetterOfNameFriends[tableView.indexPathForSelectedRow!.section])
        let friends = filterUsersForSection(DataManager.data.myFriends, firstNameLetter)
        let friend = friends[tableView.indexPathForSelectedRow!.row]
        vc.userId = friend.id
        vc.firstName = friend.firstName
        vc.lastName = friend.lastName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - вспомогательные функции
    
    private func loadDataFromBD(){
        DataManager.data.myFriends = DataManager.data.readFromDatabase(Friend.self)
        firstLetterOfNameFriends = DataManager.data.getFirstLettersOfTheNameList(in: DataManager.data.myFriends)
    }
    
    /// Распределение пользователей по с екциям
    /// - Parameters:
    ///   - friends: массив пользователей
    ///   - letterForFilter: Инициал имени
    /// - Returns: массив полдьзователей с указанным инициалом
    private func filterUsersForSection(_ friends: [Friend], _ letterForFilter: Character) -> [Friend] {
        let arrayUsersForSection = friends.filter {$0.firstName.first == letterForFilter}
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
        
        createLableForNameSearchControl(firstLetterOfNameFriends)
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
