//
//  Tic_Tac_Toe_vs_BenTests.swift
//  Tic Tac Toe vs BenTests
//
//  Created by Benjamin Breton on 07/12/2021.
//

import XCTest
@testable import Tic_Tac_Toe_vs_Ben

class GridTests: XCTestCase {

    func testGivenNewGameBeginsWhenAIHasToBeginThenAIIsCurrentPlayer() throws {
        let vm = GridViewModel(beginner: .ai)
        XCTAssert(vm.currentPlayer == .ai)
    }
    func testGivenNewGameBeginsWhenPlayerHasToBeginThenPlayerIsCurrentPlayer() throws {
        let vm = GridViewModel(beginner: .player)
        XCTAssert(vm.currentPlayer == .player)
    }
    
    func testGivenAPlayerHasToPlayWhenHeDoesThenTheBoxIsOwnedTheGameCantContinueUntilAllWasSavedAndItsNextPlayersRound() throws {
        let vm = GridViewModel(beginner: .ai)
        XCTAssert(GridBox.box00.owner == .none)
        XCTAssertFalse(vm.hasToWait)
        vm.boxButtonHasBeenHitten(.box00)
        XCTAssert(vm.boxHasBeenChoosen)
        XCTAssert(vm.hasToWait)
        vm.playerDidChoose(.box00)
        XCTAssertFalse(vm.hasToWait)
        vm.nextPlayer()
        XCTAssert(GridBox.box00.owner == .ai)
        XCTAssert(vm.currentPlayer == .player)
    }
    func testGivenAPlayerCanMakeAlineWhenHeDoesThenTheGameIsOver() throws {
        let vm = GridViewModel(beginner: .ai)
        XCTAssert(vm.canContinue)
        choose(.box00, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box01, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box11, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box22, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box20, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box10, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box02, viewModel: vm)
        XCTAssert(vm.victoriousPlayer == .ai)
    }
    func testGivenAPlayerHasToPlayTheLastBoxWhenHeDoesThenTheGameIsOver() throws {
        let vm = GridViewModel(beginner: .ai)
        XCTAssert(vm.canContinue)
        choose(.box00, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box11, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box22, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box01, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box21, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box20, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box02, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box12, viewModel: vm)
        XCTAssert(vm.canContinue)
        choose(.box10, viewModel: vm)
        XCTAssertFalse(vm.canContinue)
        XCTAssert(vm.currentPlayer == .none)
    }
    func testGivenABoxHasBeenChoosedWhenExitGameDuringSavingsThenSavingsResumeWhenGameIsRestarted() throws {
        var viewModel: GridViewModel? = GridViewModel(beginner: .ai)
        var vm = try XCTUnwrap(viewModel)
        XCTAssert(GridBox.box00.owner == .none)
        XCTAssertFalse(vm.hasToWait)
        vm.boxButtonHasBeenHitten(.box00)
        XCTAssert(vm.hasToWait)
        viewModel = nil
        viewModel = GridViewModel()
        vm = try XCTUnwrap(viewModel)
        XCTAssertFalse(vm.hasToWait)
        XCTAssert(GridBox.box00.owner == .ai)
        XCTAssert(vm.currentPlayer == .player)
    }
    
    func testGivenAGameBeganWhenHitResetButtonThenTheGameIsDeleted() throws {
        let vm = GridViewModel(beginner: .ai)
        XCTAssert(vm.canContinue)
        choose(.box00, viewModel: vm)
        XCTAssertFalse(vm.resetButtonHasBeenHitten)
        XCTAssert(vm.canContinue)
        choose(.box11, viewModel: vm)
        XCTAssert(vm.canContinue)
        vm.reset()
        XCTAssert(vm.resetButtonHasBeenHitten)
        XCTAssert(vm.currentPlayer == .player)
        for box in GridBox.allCases {
            XCTAssert(box.owner == .none)
        }
        choose(.box00, viewModel: vm)
        XCTAssertFalse(vm.resetButtonHasBeenHitten)
    }
    
    func testGivenAIHasToPlayWhenItsPlayingThenViewModelKnows() throws {
        let vm = GridViewModel(beginner: .ai)
        XCTAssert(vm.aiHasToPlay)
        vm.aiIsPlaying()
        XCTAssertFalse(vm.aiHasToPlay)
    }
    
    private func choose(_ box: GridBox, viewModel: GridViewModel) {
        viewModel.boxButtonHasBeenHitten(box)
        viewModel.playerDidChoose(box)
        viewModel.nextPlayer()
    }
    
}
