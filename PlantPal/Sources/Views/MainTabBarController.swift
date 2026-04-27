import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }
    
    private func setupTabs() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeVC.tabBarItem.accessibilityIdentifier = "tab_home"
        
        let plantsVC = UINavigationController(rootViewController: MyPlantsViewController())
        plantsVC.tabBarItem = UITabBarItem(title: "My Plants", image: UIImage(systemName: "leaf"), selectedImage: UIImage(systemName: "leaf.fill"))
        plantsVC.tabBarItem.accessibilityIdentifier = "tab_myplants"
        
        let discoverVC = UINavigationController(rootViewController: DiscoverViewController())
        discoverVC.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        discoverVC.tabBarItem.accessibilityIdentifier = "tab_discover"
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        profileVC.tabBarItem.accessibilityIdentifier = "tab_profile"
        
        viewControllers = [homeVC, plantsVC, discoverVC, profileVC]
    }
    
    private func setupAppearance() {
        tabBar.tintColor = ThemeService.shared.colors.primary
        tabBar.backgroundColor = ThemeService.shared.surfaceColor
    }
}
