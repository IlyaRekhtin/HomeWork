

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
        ApiManager.shared.fetchDataFromApi(forMethod: .usersGet)
        
    }
    
   
}

