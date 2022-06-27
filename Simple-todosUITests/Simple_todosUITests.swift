//
//  Simple_todosUITests.swift
//  Simple-todosUITests
//
//  Created by 7Peaks on 23/6/2565 BE.
//

@testable import Simple_todos
import XCTest

class Simple_todosUITests: XCTestCase {
    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testCreateTodos() throws {
        let app = XCUIApplication()
        // init navigation bar
        let simpleTodosNavigationBar = app.navigationBars["Simple-Todos"]
        simpleTodosNavigationBar.children(matching: .button).element.tap()
        // init text field
        let todoTextField = app.textFields["some task..."]
        XCTAssert(todoTextField.exists)

        todoTextField.tap()
        app/*@START_MENU_TOKEN@*/ .keyboards.buttons["Done"]/*[[".keyboards",".buttons[\"done\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[2,0]]@END_MENU_TOKEN@*/ .tap()
        app.alerts["Create failed."].scrollViews.otherElements.buttons["Confirm"].tap()
        todoTextField.tap()
        todoTextField.typeText("UI testing.")
        app.keyboards.buttons["Done"].tap()
        simpleTodosNavigationBar.buttons["add"].tap()
        todoTextField.tap()
        todoTextField.typeText("Todo for UI test02.")
//
        // init create button
        let createButton = app/*@START_MENU_TOKEN@*/ .buttons["Create"].staticTexts["Create"]/*[[".buttons[\"Create\"].staticTexts[\"Create\"]",".staticTexts[\"Create\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssert(createButton.exists)
        createButton.tap()
    }
}
