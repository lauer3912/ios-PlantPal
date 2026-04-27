import XCTest

final class PlantPalUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
    }
    
    func testLaunchPerformance() {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func testMainTabNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.tabBars.buttons["Home"].exists)
        XCTAssertTrue(app.tabBars.buttons["My Plants"].exists)
        XCTAssertTrue(app.tabBars.buttons["Discover"].exists)
        XCTAssertTrue(app.tabBars.buttons["Profile"].exists)
        
        app.tabBars.buttons["My Plants"].tap()
        XCTAssertTrue(app.navigationBars["My Plants"].exists)
        
        app.tabBars.buttons["Discover"].tap()
        XCTAssertTrue(app.navigationBars["Discover"].exists)
    }
}
