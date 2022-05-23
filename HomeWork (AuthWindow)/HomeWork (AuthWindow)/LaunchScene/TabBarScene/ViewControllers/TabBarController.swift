

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabController()
    }
 
    private func configTabController(){
        tabBarController?.tabBar.scrollEdgeAppearance?.backgroundColor = .white
        tabBarController?.tabBar.standardAppearance.backgroundColor = .white
    }
   
}

