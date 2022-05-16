

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

