import UIKit

class ThemeService {
    static let shared = ThemeService()
    
    struct Colors {
        let primary = UIColor(hex: "#22C55E")
        let primaryDark = UIColor(hex: "#16A34A")
        let secondary = UIColor(hex: "#84CC16")
        let backgroundLight = UIColor(hex: "#FAFAF5")
        let backgroundDark = UIColor(hex: "#1A1C19")
        let surfaceLight = UIColor.white
        let surfaceDark = UIColor(hex: "#2D3129")
        let textPrimaryLight = UIColor(hex: "#1F2937")
        let textSecondaryLight = UIColor(hex: "#6B7280")
        let textPrimaryDark = UIColor(hex: "#F9FAFB")
        let textSecondaryDark = UIColor(hex: "#9CA3AF")
        let accent = UIColor(hex: "#F59E0B")
        let error = UIColor(hex: "#EF4444")
        let success = UIColor(hex: "#22C55E")
        let warning = UIColor(hex: "#F59E0B")
    }
    
    var colors = Colors()
    
    private var isDarkMode: Bool {
        return UserDefaults.standard.string(forKey: "preferredTheme") == "dark" ||
               (UserDefaults.standard.string(forKey: "preferredTheme") != "light" && 
                UITraitCollection.current.userInterfaceStyle == .dark)
    }
    
    func applyTheme() {
        let navBarAppearance = UINavigationBarAppearance()
        if isDarkMode {
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = colors.surfaceDark
            navBarAppearance.titleTextAttributes = [.foregroundColor: colors.textPrimaryDark]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: colors.textPrimaryDark]
        } else {
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = colors.surfaceLight
            navBarAppearance.titleTextAttributes = [.foregroundColor: colors.textPrimaryLight]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: colors.textPrimaryLight]
        }
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = colors.primary
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = isDarkMode ? colors.surfaceDark : colors.surfaceLight
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = colors.primary
    }
    
    var backgroundColor: UIColor {
        isDarkMode ? colors.backgroundDark : colors.backgroundLight
    }
    
    var surfaceColor: UIColor {
        isDarkMode ? colors.surfaceDark : colors.surfaceLight
    }
    
    var textPrimary: UIColor {
        isDarkMode ? colors.textPrimaryDark : colors.textPrimaryLight
    }
    
    var textSecondary: UIColor {
        isDarkMode ? colors.textSecondaryDark : colors.textSecondaryLight
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
