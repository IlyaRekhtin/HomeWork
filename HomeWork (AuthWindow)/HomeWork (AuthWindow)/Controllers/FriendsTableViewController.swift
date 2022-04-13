//
//  FrandsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit
import SnapKit

class FriendsViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private var nameSearchControl: NameSearchControl!
    
    private var users = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationsForTableView()
        configurationForNameSearchControl()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationController()
    }
    
//MARK: - NavBarSettings
    private func configNavigationController(){
        
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
       
    }
    
    private func configurationsForTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.reuseID)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
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
            make.trailing.equalToSuperview().inset(8)
        }
        
        nameSearchControl.addAction(UIAction(handler: { _ in
            self.tableView.scrollToRow(at: self.nameSearchControl.indexPuth!, at: .top, animated: true)
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
    
    @IBAction func exitForAccount(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "sizeForLayoutForFotoGallary")
        dismiss(animated: true)
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
            guard let vc = storyboard?.instantiateViewController(identifier: "FriendFotoCollectionViewController") as? FriendFotoCollectionViewController else {return}
            let firstNameLetter = Character(DataBase.data.getFirstLettersOfTheName()[tableView.indexPathForSelectedRow!.section])
            users = filterUsersForSection(DataBase.data.friends, firstNameLetter)
            let user = users[tableView.indexPathForSelectedRow!.row]
            vc.user = user
            
            self.navigationController?.pushViewController(vc, animated: true)
          
        
        }
       //MARK: - вспомогательные функции
        private func filterUsersForSection(_ users: [Person], _ letterForFilter: Character) -> [Person] {
            var arrayUsersForSection = [Person]()
            for user in users {
                if user.name.first == letterForFilter {
                    arrayUsersForSection.append(user)
                }
            }
            return arrayUsersForSection
        }
}
