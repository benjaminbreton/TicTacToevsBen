//
//  Tic_Tac_Toe_vs_BenUITests.swift
//  Tic Tac Toe vs BenUITests
//
//  Created by Benjamin Breton on 07/12/2021.
//

import XCTest

class Tic_Tac_Toe_vs_BenUITests: XCTestCase {
    
    private var app: XCUIApplication?
    private var allButtonsNames: [String] = "reset/box00/box01/box02/box10/box11/box12/box20/box21/box22".split(separator: "/").map({ "\($0)" })
    
    private var disabledButtonCount: Int  {
        app?.buttons.allElementsBoundByAccessibilityElement.map({ $0.isEnabled ? 0 : 1 }).reduce(0, +) ?? -1
    }
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app?.launch()
        try resetGame()
    }

    override func tearDown() {
        app = nil
    }
    
    // MARK: - Launch tests
    
    func testGivenAppHasBeenLaunchedWhenAppearsThenGridAppears() throws {
        // UI tests must launch the application that they test.
        let app = try unwrapApp()
        XCTAssert(app.buttons.count == 10)
        XCTAssert(app.staticTexts["message"].exists)
        XCTAssert(app.staticTexts["title"].exists)
        XCTAssert(app.staticTexts["title"].label == "Tic Tac Toe vs Ben")
        let expectationSettings = try getPlayerTurnExpectation(expectationName: "player")
        wait(for: [expectationSettings.expectation], timeout: expectationSettings.timeout)
        XCTAssert(disabledButtonCount == 0 || disabledButtonCount == 1)
    }
    
    func testGivenAppHasBeenLaunchedWhenChangeOrientationThenGridStillAppears() throws {
        // UI tests must launch the application that they test.
        let app = try unwrapApp()
        XCUIDevice.shared.orientation = .landscapeLeft
        XCTAssert(app.buttons.count == 10)
        XCTAssert(app.staticTexts["message"].exists)
        XCTAssert(app.staticTexts["title"].exists)
        XCTAssert(app.staticTexts["title"].label == "Tic Tac Toe vs Ben")
        let expectationSettings = try getPlayerTurnExpectation(expectationName: "player")
        wait(for: [expectationSettings.expectation], timeout: expectationSettings.timeout)
        XCTAssert(disabledButtonCount == 0 || disabledButtonCount == 1)
        XCUIDevice.shared.orientation = .portrait
    }
    
    // MARK: - Victory tests
    
    // diagonal line
    func testGivenAiBeganWhenPlayerDidLoseThenLineIsDisplayed() throws {
        let app = try unwrapApp()
        let expectationAiBeginning = try getAIBegininngExpectation(expectationName: "aiBeginning")
        wait(for: [expectationAiBeginning.expectation], timeout: expectationAiBeginning.timeout)
        // first choice
        app.buttons["box01"].tap()
        let expectationPlayer1 = try getPlayerTurnExpectation(expectationName: "playerTurn1")
        wait(for: [expectationPlayer1.expectation], timeout: expectationPlayer1.timeout)
        // second choice
        app.buttons["box21"].tap()
        let aiVictoryExpectation = try getAIVictoryExpectation(expectationName: "aiVictory")
        wait(for: [aiVictoryExpectation.expectation], timeout: aiVictoryExpectation.timeout)
        // victory line verification
        XCTAssert(app.otherElements["victoryLine"].exists)
    }
    // horizontal line
    func testGivenPlayerBeganWhenPlayerDidLoseWithHorizontalLineThenLineIsDisplayed() throws {
        let app = try unwrapApp()
        let expectationPlayerBeginning = try getPlayerBegininngExpectation(expectationName: "playerBegins")
        wait(for: [expectationPlayerBeginning.expectation], timeout: expectationPlayerBeginning.timeout)
        // first choice
        app.buttons["box00"].tap()
        let expectationPlayer1 = try getPlayerTurnExpectation(expectationName: "playerTurn1")
        wait(for: [expectationPlayer1.expectation], timeout: expectationPlayer1.timeout)
        // second choice
        app.buttons["box20"].tap()
        let expectationPlayer2 = try getPlayerTurnExpectation(expectationName: "playerTurn2")
        wait(for: [expectationPlayer2.expectation], timeout: expectationPlayer2.timeout)
        // third choice
        app.buttons["box21"].tap()
        let aiVictoryExpectation = try getAIVictoryExpectation(expectationName: "aiVictory")
        wait(for: [aiVictoryExpectation.expectation], timeout: aiVictoryExpectation.timeout)
        // victory line verification
        XCTAssert(app.otherElements["victoryLine"].exists)
    }
    // vertical line
    func testGivenPlayerBeganWhenPlayerDidLoseWithVerticalLineThenLineIsDisplayed() throws {
        let app = try unwrapApp()
        let expectationPlayerBeginning = try getPlayerBegininngExpectation(expectationName: "playerBegins")
        wait(for: [expectationPlayerBeginning.expectation], timeout: expectationPlayerBeginning.timeout)
        // first choice
        app.buttons["box00"].tap()
        let expectationPlayer1 = try getPlayerTurnExpectation(expectationName: "playerTurn1")
        wait(for: [expectationPlayer1.expectation], timeout: expectationPlayer1.timeout)
        // second choice
        app.buttons["box02"].tap()
        let expectationPlayer2 = try getPlayerTurnExpectation(expectationName: "playerTurn2")
        wait(for: [expectationPlayer2.expectation], timeout: expectationPlayer2.timeout)
        // third choice
        app.buttons["box10"].tap()
        let aiVictoryExpectation = try getAIVictoryExpectation(expectationName: "aiVictory")
        wait(for: [aiVictoryExpectation.expectation], timeout: aiVictoryExpectation.timeout)
        // victory line verification
        XCTAssert(app.otherElements["victoryLine"].exists)
    }
    
    // MARK: - Draw tests
    
    func testGivenAiBeganWhenPlayerAvoidsDefeatThenDrawIsDisplayed() throws {
        let app = try unwrapApp()
        let expectationAiBeginning = try getAIBegininngExpectation(expectationName: "aiBeginning")
        wait(for: [expectationAiBeginning.expectation], timeout: expectationAiBeginning.timeout)
        // first choice
        app.buttons["box11"].tap()
        let expectationPlayer1 = try getPlayerTurnExpectation(expectationName: "playerTurn1")
        wait(for: [expectationPlayer1.expectation], timeout: expectationPlayer1.timeout)
        // second choice
        app.buttons["box01"].tap()
        let expectationPlayer2 = try getPlayerTurnExpectation(expectationName: "playerTurn2")
        wait(for: [expectationPlayer2.expectation], timeout: expectationPlayer2.timeout)
        // third choice
        let choice3: String
        if try isFreeBox("box20") {
            choice3 = "box20"
        } else {
            choice3 = "box22"
        }
        app.buttons[choice3].tap()
        let expectationPlayer3 = try getPlayerTurnExpectation(expectationName: "playerTurn3")
        wait(for: [expectationPlayer3.expectation], timeout: expectationPlayer3.timeout)
        // last choice
        let choice4: String
        if choice3 == "box20" {
            choice4 = "box12"
        } else {
            choice4 = "box10"
        }
        app.buttons[choice4].tap()
        let expectationDraw = try getDrawExpectation(expectationName: "draw")
        wait(for: [expectationDraw.expectation], timeout: expectationDraw.timeout)
        XCTAssert(app.staticTexts["message"].label == "match nul ! 🙅")
    }
    
    private func isFreeBox(_ name: String) throws -> Bool {
        let app = try unwrapApp()
        return app.buttons[name].isEnabled
    }
    
    
    // MARK: - Supporting methods
    
    private func unwrapApp() throws -> XCUIApplication {
        let app = try XCTUnwrap(self.app)
        return app
    }
    
    // Human player begins expectations
    
    typealias ExpectationSettings = (expectation: XCTestExpectation, timeout: TimeInterval)
    
    private func getPlayerBegininngExpectation(expectationName: String) throws -> ExpectationSettings {
        let expectationToFulfill = expectation(description: expectationName)
        try performPlayerBeginsExpectations(player: .player, expectationName: expectationName, expectation: expectationToFulfill, timeout: 20)
        return (expectation: expectationToFulfill, timeout: 20)
    }
    
    // AI begins expectations
    
    private func getAIBegininngExpectation(expectationName: String) throws -> ExpectationSettings {
        let expectationToFulfill = expectation(description: expectationName)
        try performPlayerBeginsExpectations(player: .ai, expectationName: expectationName, expectation: expectationToFulfill, timeout: 20)
        return (expectation: expectationToFulfill, timeout: 20)
    }
    
    // Player begins expectations
    
    enum Player { case ai, player }
    private func performPlayerBeginsExpectations(player: Player, expectationName: String, expectation: XCTestExpectation, timeout: TimeInterval) throws {
        let expectation1 = try getPlayerTurnExpectation(expectationName: "\(expectationName)1")
        wait(for: [expectation1.expectation], timeout: expectation1.timeout)
        if isPlayerBeginning(player) {
            expectation.fulfill()
            return
        }
        try resetGame()
        let expectation2 = try getPlayerTurnExpectation(expectationName: "\(expectationName)2")
        wait(for: [expectation2.expectation], timeout: expectation2.timeout)
        expectation.fulfill()
    }
    private func isPlayerBeginning(_ player: Player) -> Bool {
        switch player {
        case .ai:
            return disabledButtonCount == 1
        case .player:
            return disabledButtonCount == 0
        }
    }
    
    // Player turn expectations
    
    private func getPlayerTurnExpectation(expectationName: String) throws -> ExpectationSettings {
        let expectationToFulfill = expectation(description: expectationName)
        try performMessageWaiting(expectationToFulfill: expectationToFulfill, timeout: 10, message: "à toi ...")
        return (expectation: expectationToFulfill, timeout: 10)
    }
    private func performMessageWaiting(expectationToFulfill: XCTestExpectation, timeout: TimeInterval, message: String) throws {
        let app = try unwrapApp()
        let label = app.staticTexts["message"]
        let predicate = NSPredicate(format: "label == %@", message)
        let expectation0 = expectation(for: predicate, evaluatedWith: label, handler: nil)
        wait(for: [expectation0], timeout: timeout)
        expectationToFulfill.fulfill()
    }

    // victory expectation
    
    private func getAIVictoryExpectation(expectationName: String) throws -> ExpectationSettings {
        let expectationToFulfill = expectation(description: expectationName)
        try performMessageWaiting(expectationToFulfill: expectationToFulfill, timeout: 10, message: "J'ai gagné, désolé ... 🤷")
        return (expectation: expectationToFulfill, timeout: 10)
    }
    
    // draw expectation
    
    private func getDrawExpectation(expectationName: String) throws -> ExpectationSettings {
        let expectationToFulfill = expectation(description: expectationName)
        try performMessageWaiting(expectationToFulfill: expectationToFulfill, timeout: 10, message: "match nul ! 🙅")
        return (expectation: expectationToFulfill, timeout: 10)
    }
    
    // reset game
    
    func resetGame() throws {
        let app = try unwrapApp()
        app.buttons["reset"].tap()
    }
}
