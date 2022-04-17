//
//  TabBarViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabController()
        loadDataFromApi()
    }
 
    private func configTabController(){
        tabBarController?.tabBar.scrollEdgeAppearance?.backgroundColor = .systemGreen
        
        tabBarController?.tabBar.standardAppearance.backgroundColor = .systemGreen
    }
    
   
    func loadDataFromApi(){
        guard let url = ApiManager.shared.getURL(for: .api, and: .friendsGet) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
           guard let data = data  else { return }
           do{
               let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
               print(json)
           }catch{
               print(error.localizedDescription)
           }
           
       }.resume()
        
    }
    
   
}

