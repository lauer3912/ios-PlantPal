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
        
        let plantsVC = UINavigationController(rootViewController: MyPlantsViewController())
        plantsVC.tabBarItem = UITabBarItem(title: "My Plants", image: UIImage(systemName: "leaf"), selectedImage: UIImage(systemName: "leaf.fill"))
        
        let discoverVC = UINavigationController(rootViewController: DiscoverViewController())
        discoverVC.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [homeVC, plantsVC, discoverVC, profileVC]
    }
    
    private func setupAppearance() {
        tabBar.tintColor = ThemeService.shared.colors.primary
        tabBar.backgroundColor = ThemeService.shared.surfaceColor
    }
}
