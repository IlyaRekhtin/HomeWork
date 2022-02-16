//
//  TabBarViewController.swift
//  HomeWork (AuthWindow)
//
//  Created by Илья Рехтин on 16.02.2022.
//

import UIKit

class TabBarController: UITabBarController {
//    private let searchButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: <#T##Selector?#>)
//        
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configControllers()
        
        
    }
    
    
    private func configControllers(){

        self.tabBarItem = UITabBarItem(title: "Friends", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
    }
}
