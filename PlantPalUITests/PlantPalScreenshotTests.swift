import XCTest

final class PlantPalScreenshotTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        sleep(2)
    }
    
    func testHomeScreen() {
        let tabBar = app.tabBars.firstMatch
        if tabBar.exists {
            tabBar.buttons["Home"].tap()
            sleep(1)
        }
        capture("Home")
    }
    
    func testMyPlantsScreen() {
        let tabBar = app.tabBars.firstMatch
        if tabBar.exists {
            tabBar.buttons["My Plants"].tap()
            sleep(1)
        }
        capture("MyPlants")
    }
    
    func testDiscoverScreen() {
        let tabBar = app.tabBars.firstMatch
        if tabBar.exists {
            tabBar.buttons["Discover"].tap()
            sleep(1)
        }
        capture("Discover")
    }
    
    func testProfileScreen() {
        let tabBar = app.tabBars.firstMatch
        if tabBar.exists {
            tabBar.buttons["Profile"].tap()
            sleep(1)
        }
        capture("Profile")
    }
    
    private func capture(_ name: String) {
        let screenshot = XCUIScreen.main.screenshot()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        let timestamp = formatter.string(from: Date())
        let filename = "/tmp/PlantPal_\(name)_\(timestamp).png"
        
        let data = screenshot.pngRepresentation
        try? data.write(to: URL(fileURLWithPath: filename))
        print("Screenshot saved: \(filename)")
    }
}
