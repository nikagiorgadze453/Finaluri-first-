import UIKit

class mainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
    }
    func setupViewControllers() {
        let homeVC = homeViewController()
        let searchVC = searchViewController()
        let favoritesVC = FavoritesViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        favoritesNav.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "bookmark"), tag: 2)
        
        setViewControllers([homeNav, searchNav, favoritesNav], animated: false)
    }
    
    func setupTabBarAppearance() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemBackground
    }
    
    func testfunction() {
        print("hello")
    }
}
