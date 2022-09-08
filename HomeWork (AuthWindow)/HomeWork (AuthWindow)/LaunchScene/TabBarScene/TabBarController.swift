

import UIKit

final class TabBarController: UITabBarController {
    
    private enum TabBarItem: Int {
        case newfeed
        case friends
        case groups
        
        var title: String {
            switch self {
            case .newfeed:
                return "Новости"
            case .friends:
                return "Друзья"
            case .groups:
                return "Сообщества"
            }
        }
        
        var iconName: String {
            switch self {
            case .newfeed:
                return "newspaper"
            case .friends:
                return "person.3"
            case .groups:
                return "rectangle.3.group"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    
    private func setupTabBar() {
    
        tabBarController?.tabBar.scrollEdgeAppearance?.backgroundColor = .white
        tabBarController?.tabBar.standardAppearance.backgroundColor = .white
        
        let dataSource: [TabBarItem] = [.newfeed, .friends, .groups]
        
            self.viewControllers = dataSource.map {
                switch $0 {
                case .newfeed:
                    let newsfeedViewController = NewsfeedTableViewController()
                    return self.wrappedInNavigationController(with: newsfeedViewController, title: $0.title)
                case .friends:
                    let router = FriendsRouter.start()
                    guard let friendViewController = router.entryPoint else {return UIViewController()}
                    return self.wrappedInNavigationController(with: friendViewController, title: $0.title)
                case .groups:
                    let groupsViewController = GroupsTableViewController()
                    return self.wrappedInNavigationController(with: groupsViewController, title: $0.title)
                }
            }
            self.viewControllers?.enumerated().forEach {
                $1.tabBarItem.title = dataSource[$0].title
                $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
                $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
            }
        }
    
    private func wrappedInNavigationController(with vc: UIViewController, title: Any?) -> UINavigationController {
        let nvc = CustomNavController(rootViewController: vc)
        return nvc
        }
    
}

