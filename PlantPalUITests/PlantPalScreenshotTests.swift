import XCTest

final class PlantPalScreenshotTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--uitesting"]
        app.launch()
        Thread.sleep(forTimeInterval: 2.0)
    }
    
    func tapTab(identifier: String) {
        let predicate = NSPredicate(format: "identifier == %@", identifier)
        let button = app.buttons.matching(predicate).firstMatch
        if button.exists {
            button.tap()
            Thread.sleep(forTimeInterval: 1.5)
        } else {
            print("WARNING: Could not find tab button: \(identifier)")
        }
    }
    
    func capture(_ name: String) {
        let path = "/tmp/PlantPal_\(name).png"
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: path))
        print("Screenshot saved: \(path)")
    }
    
    // MARK: - iPhone 6.9" (1320x2868) - iPhone 16 Pro Max
    
    func testiPhone_69_01_Home() {
        capture("iPhone_69_01_Home")
    }
    
    func testiPhone_69_02_MyPlants() {
        tapTab(identifier: "tab_myplants")
        capture("iPhone_69_02_MyPlants")
    }
    
    func testiPhone_69_03_Discover() {
        tapTab(identifier: "tab_discover")
        capture("iPhone_69_03_Discover")
    }
    
    func testiPhone_69_04_Profile() {
        tapTab(identifier: "tab_profile")
        capture("iPhone_69_04_Profile")
    }
}
