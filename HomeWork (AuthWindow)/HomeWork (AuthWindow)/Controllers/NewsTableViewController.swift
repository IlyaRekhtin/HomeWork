//
//  NewsTableViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 23.03.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {

    
    private var news = [News(person: DataManager.data.friends[1],
                             newsText: "When you tap a button, or select a button that has focus, the button performs ",
                             newsImages: nil,
                             myLike: false,
                             likesCount: 0),
                        News(person: DataManager.data.friends[3],
                             newsText: "HI!!!👏🖐\n 💪",
                             newsImages: [Foto(image: UIImage(named: "exp2")!),
                                          Foto(image: UIImage(named: "exp3")!),
                                          Foto(image: UIImage(named: "exp4")!),
                                          Foto(image: UIImage(named: "ava2")!)],
                             myLike: true,
                             likesCount: 10),
                        News(person: DataManager.data.friends[1], newsText: "Hello world!!", newsImages: [Foto(image: UIImage(named: "exp2")!), Foto(image: UIImage(named: "exp3")!), Foto(image: UIImage(named: "exp4")!), Foto(image: UIImage(named: "ava2")!), Foto(image: UIImage(named: "ava1")!), Foto(image: UIImage(named: "ava4")!)],
                             myLike: false,
                             likesCount: 0)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
    }

  
    
    
    
    private func configNavigationController(){
        navigationController?.navigationBar.scrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.standardAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.compactScrollEdgeAppearance = Appearance.data.appearanceForNavBarFriendsTBVC()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
        
       
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as! NewsTableViewCell
        
        cell.configurationCell(news[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
