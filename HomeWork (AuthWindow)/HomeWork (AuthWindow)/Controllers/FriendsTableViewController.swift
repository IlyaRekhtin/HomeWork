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
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationsForTableView()
        configurationForNameSearchControl()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let friendFotoVC = segue.destination as? FriendFotoCollectionViewController else {return}
        let firstNameLetter = Character(DataBase.data.getFirstLettersOfTheName()[tableview.indexPathForSelectedRow!.section])
        users = filterUsersForSection(DataBase.data.friends, firstNameLetter)
        let user = users[tableview.indexPathForSelectedRow!.row]
        friendFotoVC.user = user
    }
//MARK: - NavBarSettings
    private func configNavigationController(){
        
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configurationsForTableView() {
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableview.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseID)
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configurationForNameSearchControl() {
        nameSearchControl = NameSearchControl(frame: CGRect(x: 0, y: 0, width: 40, height: 200))
        self.view.addSubview(nameSearchControl)
        
        createLableForNameSearchControl(DataBase.data.getFirstLettersOfTheName())
        nameSearchControl.addButtonsForControl(for: nameSearchControl.letters)
        nameSearchControl.snp.makeConstraints { make in
            make.top.equalTo(self.view.frame.height / 4)
            make.trailing.equalToSuperview().inset(3)
        }
        
        nameSearchControl.addAction(UIAction(handler: { _ in
            self.tableview.scrollToRow(at: self.nameSearchControl.indexPuth!, at: .top, animated: true)
        }), for: .touchCancel)
        
        
    }
    
    
    private func createLableForNameSearchControl(_ letters: [String]) {
        for letter in letters {
            let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            lable.text = letter
            lable.textColor = .systemGreen
            
            self.nameSearchControl.letters.append(lable)
        }
    }
    
    
    
    private func createButtonForNameSearchControl(_ letters: [String]) {
        for letter in letters {
            let button = UIButton(type: .roundedRect)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.layer.cornerRadius = button.frame.width / 2
            button.setTitle(letter, for: .normal)
            button.setTitleColor(.systemGreen, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectLetter(_:)), for: .touchUpInside)
            if button.isFocused {
                print("test1")
            }
            self.nameSearchControl.buttons.append(button)
        }
    }
    
    @IBAction func exitForAccount(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "sizeForLayoutForFotoGallary")
        dismiss(animated: true)
    }
    
    @objc private func selectLetter(_ sender: UITouch) {
        
        
    }
}

    extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - настройка секций
        func numberOfSections(in tableView: UITableView) -> Int {
            return DataBase.data.getFirstLettersOfTheName().count
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return DataBase.data.getFirstLettersOfTheName()[section]
        }
        
        
    //MARK: - настройка ячейки
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filterUsersForSection(DataBase.data.friends, Character(DataBase.data.getFirstLettersOfTheName()[section])).count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseID, for: indexPath) as! FriendsTableViewCell
            let firstNameLetter = Character(DataBase.data.getFirstLettersOfTheName()[indexPath.section])
            let usersForSection = filterUsersForSection(DataBase.data.friends, firstNameLetter)
            let user = usersForSection[indexPath.row]
            cell.getRowForFriendsVC(for: user)
            cell.selectionStyle = .none
            tableView.rowHeight = cell.getimageSize().height + 10
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToFoto", sender: nil)
        }
       //MARK: - вспомогательные функции
        private func filterUsersForSection(_ users: [User], _ letterForFilter: Character) -> [User] {
            var arrayUsersForSection = [User]()
            for user in users {
                if user.name.first == letterForFilter {
                    arrayUsersForSection.append(user)
                }
            }
            return arrayUsersForSection
        }
}
