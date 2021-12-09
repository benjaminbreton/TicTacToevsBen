//
//  Tic_Tac_Toe_vs_BenTests.swift
//  Tic Tac Toe vs BenTests
//
//  Created by Benjamin Breton on 07/12/2021.
//

import XCTest
@testable import Tic_Tac_Toe_vs_Ben

class Tic_Tac_Toe_vs_BenTests: XCTestCase {
    
    var gridViewModel: GridViewModel?
    override func setUp() {
        gridViewModel = GridViewModel()
        gridViewModel?.reset()
    }
    override func tearDown() {
        gridViewModel?.reset()
        gridViewModel = nil
    }

    func testGivenNewGameBeginsWhenAIHasToBeginThenAIIsCurrentPlayer() throws {
        let vm = GridViewModel(beginner: .me)
        XCTAssert(vm.currentPlayer == .me)
    }
    func testGivenNewGameBeginsWhenPlayerHasToBeginThenPlayerIsCurrentPlayer() throws {
        let vm = GridViewModel(beginner: .player)
        XCTAssert(vm.currentPlayer == .player)
    }
    
}
