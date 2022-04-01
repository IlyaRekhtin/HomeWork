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
        
    }
 
    private func configTabController(){
        tabBarController?.tabBar.scrollEdgeAppearance?.backgroundColor = .systemGreen
        
        tabBarController?.tabBar.standardAppearance.backgroundColor = .systemGreen
    }
    
   
    
    
   
}

