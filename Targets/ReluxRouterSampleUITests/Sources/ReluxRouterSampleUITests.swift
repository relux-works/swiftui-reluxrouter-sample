import XCTest

final class ReluxRouterSampleUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testReluxAndNativePagesShareHonestProjection() throws {
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 5))
        assertProjectionCount("0")
        attachScreenshot(step: 1, "root")

        app.buttons["sample.action.open-catalog-relux"].tap()

        XCTAssertTrue(app.navigationBars["Catalog item-42"].waitForExistence(timeout: 5))
        assertProjectionCount("1")
        assertProjectionRow(0, contains: ["CatalogModule", "item-42"])
        attachScreenshot(step: 2, "catalog-relux-page")

        app.buttons["sample.action.open-profile-native-from-catalog"].tap()

        XCTAssertTrue(app.navigationBars["Profile"].waitForExistence(timeout: 5))
        assertProjectionCount("2")
        assertProjectionRow(0, contains: ["CatalogModule", "item-42"])
        assertProjectionRow(1, contains: ["ProfileModule", "native-7", "item-42"])
        attachScreenshot(step: 3, "profile-native-page")

        app.navigationBars["Profile"].buttons.element(boundBy: 0).tap()

        XCTAssertTrue(app.navigationBars["Catalog item-42"].waitForExistence(timeout: 5))
        assertProjectionCount("1")
        assertProjectionRow(0, contains: ["CatalogModule", "item-42"])
        attachScreenshot(step: 4, "back-to-catalog")

        app.navigationBars["Catalog item-42"].buttons.element(boundBy: 0).tap()

        XCTAssertTrue(app.navigationBars["ReluxRouter"].waitForExistence(timeout: 5))
        assertProjectionCount("0")
        attachScreenshot(step: 5, "back-to-root")
    }

    private func assertProjectionCount(_ expected: String) {
        let count = app.staticTexts["sample.projection.count"]
        XCTAssertTrue(count.waitForExistence(timeout: 3))
        XCTAssertTrue(count.label.contains(expected), "Expected projection count \(expected), got \(count.label)")
    }

    private func assertProjectionRow(_ index: Int, contains fragments: [String]) {
        let row = app.staticTexts["sample.projection.row.\(index)"]
        XCTAssertTrue(row.waitForExistence(timeout: 3), "Missing projection row \(index)")
        for fragment in fragments {
            XCTAssertTrue(row.label.contains(fragment), "Expected row \(index) to contain \(fragment), got \(row.label)")
        }
    }

    private func attachScreenshot(step: Int, _ description: String) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = String(
            format: "Run_sample__Test_testReluxAndNativePagesShareHonestProjection__Step_%02d__000000__%@",
            step,
            description
        )
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
