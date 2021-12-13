//
//  AITests.swift
//  Tic Tac Toe vs BenTests
//
//  Created by Benjamin Breton on 10/12/2021.
//

import XCTest
@testable import Tic_Tac_Toe_vs_Ben

class AITests: XCTestCase {
    
    private var aiViewModel: AIViewModel?
    private var gridViewModel: GridViewModel?

    // MARK: - AI has to begin
    
    // First Choice
    
    func testAIHasToBeginWhenBeganThenItChoosedACorner() throws {
        let viewmodels = createViewModels(beginner: .ai)
        XCTAssert(viewmodels.grid.aiHasToPlay)
        viewmodels.grid.aiIsPlaying()
        XCTAssertFalse(viewmodels.grid.aiHasToPlay)
        viewmodels.ai.play()
        let decision = try XCTUnwrap(viewmodels.ai.decision)
        XCTAssert(decision.isCorner)
        viewmodels.ai.reset()
        try choose(decision)
        XCTAssertNil(viewmodels.ai.decision)
        XCTAssert(decision.owner == .ai)
    }
    
    // Second choice
    
    func testGivenPlayerFirstChoiceIsCenterWhenAiHasToPlayThenItChoosedTheOppositeCorner() throws {
        createViewModels(beginner: .ai)
        let box1 = try aiPlays()
        try choose(.box11)
        let box2 = try aiPlays()
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isCorner)
        XCTAssert(box2 == box1.oppositeBox)
    }
    func testGivenPlayerFirstChoiceIsCornerWhenAiHasToPlayThenItChoosedAnotherCorner() throws {
        createViewModels(beginner: .ai)
        let box1 = try aiPlays()
        let boxToPlay = GridBox.allCases.compactMap({ $0.isCorner && $0.owner == .none ? $0 : nil })[0]
        try choose(boxToPlay)
        let box2 = try aiPlays()
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isCorner)
    }
    func testGivenPlayerFirstChoiceIsMiddleCornerWhenAiHasToPlayThenItChoosedCenter() throws {
        createViewModels(beginner: .ai)
        let box1 = try aiPlays()
        let boxToPlay = GridBox.allCases.compactMap({ $0.isMiddleCorner ? $0 : nil })[0]
        try choose(boxToPlay)
        let box2 = try aiPlays()
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isCenter)
    }
    
    // MARK: - Player began
    
    // first choice
    
    func testGivenPlayerBeganAndFirstChoiceIsCenterWhenAiHasToPlayThenItChoosedCorner() throws {
        createViewModels(beginner: .player)
        try choose(.box11)
        let box1 = try aiPlays()
        XCTAssert(box1.isCorner)
    }
    func testGivenPlayerBeganAndFirstChoiceIsCornerWhenAiHasToPlayThenItChoosedCenter() throws {
        createViewModels(beginner: .player)
        try choose(.box00)
        let box1 = try aiPlays()
        XCTAssert(box1.isCenter)
    }
    func testGivenPlayerBeganAndFirstChoiceIsMiddleCornerWhenAiHasToPlayThenItChoosedCenter() throws {
        createViewModels(beginner: .player)
        try choose(.box01)
        let box1 = try aiPlays()
        XCTAssert(box1.isCenter)
    }
    
    // second choice
    
    func testGivenPlayerBeganAndFirstChoiceIsCenterSecondIsCornerWhenAiHasToPlayThenItChoosedAnotherCorner() throws {
        createViewModels(beginner: .player)
        try choose(.box11)
        let box1 = try aiPlays()
        let boxToPlay = GridBox.allCases.compactMap({ $0.isCorner && $0.owner == .none ? $0 : nil })[0]
        try choose(boxToPlay)
        let box2 = try aiPlays()
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isCorner)
    }
    func testGivenPlayerBeganAndFirstChoiceIsCenterSecondIsOtherCornerWhenAiHasToPlayThenItChoosedAnotherCorner() throws {
        createViewModels(beginner: .player)
        try choose(.box11)
        let box1 = try aiPlays()
        let boxToPlay = GridBox.allCases.compactMap({ $0.isCorner && $0.owner == .none ? $0 : nil })[2]
        try choose(boxToPlay)
        let box2 = try aiPlays()
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isCorner)
    }
    func testGivenPlayerBeganAndFirstChoiceIsCenterSecondIsMiddleCornerWhenAiHasToPlayThenItChoosedTheOppositeMiddleCorner() throws {
        createViewModels(beginner: .player)
        try choose(.box11)
        let box1 = try aiPlays()
        let boxToPlay = GridBox.allCases.compactMap({ $0.isMiddleCorner && $0.owner == .none ? $0 : nil })[0]
        try choose(boxToPlay)
        let box2 = try aiPlays()
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isMiddleCorner)
        XCTAssert(boxToPlay.oppositeBox == box2)
    }
    func testGivenPlayerBeganAndFirstChoiceIsCornerSecondIsCornerWhenAiHasToPlayThenItChoosedMiddleCorner() throws {
        createViewModels(beginner: .player)
        try choose(.box00)
        let box1 = try aiPlays()
        let boxToPlay = GridBox.allCases.compactMap({ $0.isCorner && $0.owner == .none ? $0 : nil })[0]
        try choose(boxToPlay)
        let box2 = try aiPlays()
        XCTAssert(box1.isCenter)
        XCTAssert(box2.isMiddleCorner)
    }
    func testGivenPlayerBeganAndFirstChoiceIsCornerSecondIsMiddleCornerWhenAiHasToPlayThenItChoosedACorner() throws {
        createViewModels(beginner: .player)
        try choose(.box00)
        let box1 = try aiPlays()
        let boxToPlay = GridBox.allCases.compactMap({ $0.isMiddleCorner && $0.owner == .none ? $0 : nil })[0]
        try choose(boxToPlay)
        let box2 = try aiPlays()
        XCTAssert(box1.isCenter)
        XCTAssert(box2.isCorner)
    }
    func testGivenPlayerBeganAndFirstChoiceIsOtherCornerSecondIsCornerWhenAiHasToPlayThenItChoosedMiddleCorner() throws {
        createViewModels(beginner: .player)
        try choose(.box22)
        let box1 = try aiPlays()
        let boxToPlay = GridBox.allCases.compactMap({ $0.isCorner && $0.owner == .none ? $0 : nil })[0]
        try choose(boxToPlay)
        let box2 = try aiPlays()
        XCTAssert(box1.isCenter)
        XCTAssert(box2.isMiddleCorner)
    }
    func testGivenPlayerBeganAndFirstChoiceIsOtherCornerSecondIsMiddleCornerWhenAiHasToPlayThenItChoosedACorner() throws {
        createViewModels(beginner: .player)
        try choose(.box22)
        let box1 = try aiPlays()
        let boxToPlay = GridBox.allCases.compactMap({ $0.isMiddleCorner && $0.owner == .none ? $0 : nil })[0]
        try choose(boxToPlay)
        let box2 = try aiPlays()
        XCTAssert(box1.isCenter)
        XCTAssert(box2.isCorner)
    }
    
    // MARK: - Victory conditions
    
    func testGivenAiCanWinWhenItPlaysThenItWins() throws {
        let viewmodels = createViewModels(beginner: .ai)
        try aiPlays()
        try choose(.box10)
        try aiPlays()
        try choose(.box12)
        try aiPlays()
        XCTAssert(viewmodels.grid.victoriousPlayer == .ai)
        XCTAssertNotNil(viewmodels.grid.victoriousLine)
    }
    func testGivenPlayerCanWinWhenAiPlaysThenItChoosedTheBoxToAvoidPlayerVictory() throws {
        createViewModels(beginner: .player)
        try choose(.box00)
        try aiPlays()
        try choose(.box10)
        let box = try aiPlays()
        XCTAssert(box == .box20)
    }
    
    // MARK: - Trap player
    
    func testGivenAiCanTrapThePlayerWhenItPlaysThenItTrapsHim() throws {
        createViewModels(beginner: .ai)
        let firstAiBox = try aiPlays()
        try choose(GridBox.getBox(row: firstAiBox.row, col: 1))
        try aiPlays()
        try choose(firstAiBox.oppositeBox)
        try aiPlays()
        let aiPossibleLinesCount = GridLine.allCases.map({ $0.gridBoxes.map({ $0.owner == .ai ? 1 : $0.owner == .player ? -3 : 0 }).reduce(0, +) }).map({ $0 == 2 ? 1 : 0 }).reduce(0, +)
        XCTAssert(aiPossibleLinesCount >= 2)
    }
    
    // MARK: - Supporting methods
    
    private func choose(_ box: GridBox) throws {
        let viewModel = try XCTUnwrap(self.gridViewModel)
        viewModel.boxButtonHasBeenHitten(box)
        viewModel.playerDidChoose(box)
        viewModel.nextPlayer()
    }
    @discardableResult
    private func aiPlays() throws -> GridBox {
        let aiViewModel = try XCTUnwrap(self.aiViewModel)
        let gridViewModel = try XCTUnwrap(self.gridViewModel)
        gridViewModel.aiIsPlaying()
        aiViewModel.play()
        let decision = try XCTUnwrap(aiViewModel.decision)
        aiViewModel.reset()
        try choose(decision)
        return decision
    }
    @discardableResult
    private func createViewModels(beginner: Player) -> (grid: GridViewModel, ai: AIViewModel) {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: beginner)
        self.aiViewModel = aiViewModel
        self.gridViewModel = gridViewModel
        return (grid: gridViewModel, ai: aiViewModel)
    }
    override func tearDown() {
        aiViewModel = nil
        gridViewModel = nil
    }

}
