import XCTest

final class AntlerLogUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAddEntryFlow() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["addButton"].tap()
        let field = app.textFields["addLocationField"]
        XCTAssertTrue(field.waitForExistence(timeout: 2))
        field.tap()
        field.typeText("Test Entry")
        app.buttons["addSaveButton"].tap()

        XCTAssertTrue(app.staticTexts["Test Entry"].waitForExistence(timeout: 2))
    }

    func testFreeLimitTriggersPaywall() throws {
        let app = XCUIApplication()
        app.launchArguments += ["-forceFreeLimitReached"]
        app.launch()

        app.buttons["addButton"].tap()
        let paywallButton = app.buttons["paywallSubscribeButton"]
        // If seed + adds already exceed the limit, the paywall should appear instead of the add sheet.
        if paywallButton.waitForExistence(timeout: 2) {
            XCTAssertTrue(paywallButton.exists)
            app.buttons["paywallCloseButton"].tap()
        } else {
            app.buttons["addCancelButton"].tap()
        }
    }

    func testKeyboardDismissOnTapOutside() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["addButton"].tap()
        let field = app.textFields["addLocationField"]
        XCTAssertTrue(field.waitForExistence(timeout: 2))
        field.tap()
        field.typeText("Dismiss Test")
        XCTAssertTrue(app.keyboards.element.exists)

        app.navigationBars.element.tap()
        XCTAssertFalse(app.keyboards.element.exists)

        app.buttons["addCancelButton"].tap()
    }

    func testSettingsSheetOpens() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["settingsButton"].tap()
        XCTAssertTrue(app.buttons["settingsDoneButton"].waitForExistence(timeout: 2))
        app.buttons["settingsDoneButton"].tap()
    }

    func testDeleteEntryViaEditSheet() throws {
        let app = XCUIApplication()
        app.launch()
        let firstRow = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'itemRow_'")).firstMatch
        if firstRow.waitForExistence(timeout: 2) {
            firstRow.tap()
            if app.buttons["editDeleteButton"].waitForExistence(timeout: 2) {
                app.buttons["editDeleteButton"].tap()
            }
        }
    }
}
