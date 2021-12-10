//
//  AITests.swift
//  Tic Tac Toe vs BenTests
//
//  Created by Benjamin Breton on 10/12/2021.
//

import XCTest
@testable import Tic_Tac_Toe_vs_Ben

class AITests: XCTestCase {

    // MARK: - AI has to begin
    
    // First Choice
    
    func testAIHasToBeginWhenBeganThenItChoosedACorner() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .ai)
        XCTAssert(gridViewModel.aiHasToPlay)
        gridViewModel.aiIsPlaying()
        XCTAssertFalse(gridViewModel.aiHasToPlay)
        aiViewModel.play()
        let decision = try XCTUnwrap(aiViewModel.decision)
        XCTAssert(decision.isCorner)
        aiViewModel.reset()
        choose(decision, viewModel: gridViewModel)
        XCTAssertNil(aiViewModel.decision)
        XCTAssert(decision.owner == .ai)
    }
    
    // Second choice
    
    func testGivenPlayerFirstChoiceIsCenterWhenAiHasToPlayThenItChoosedTheOppositeCorner() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .ai)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        choose(.box11, viewModel: gridViewModel)
        let box2 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isCorner)
        XCTAssert(box2 == box1.oppositeBox)
    }
    func testGivenPlayerFirstChoiceIsCornerWhenAiHasToPlayThenItChoosedAnotherCorner() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .ai)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        let boxToPlay = GridBox.allCases.compactMap({ $0.isCorner && $0.owner == .none ? $0 : nil })[0]
        choose(boxToPlay, viewModel: gridViewModel)
        let box2 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isCorner)
    }
    func testGivenPlayerFirstChoiceIsMiddleCornerWhenAiHasToPlayThenItChoosedCenter() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .ai)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        let boxToPlay = GridBox.allCases.compactMap({ $0.isMiddleCorner ? $0 : nil })[0]
        choose(boxToPlay, viewModel: gridViewModel)
        let box2 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isCenter)
    }
    
    // MARK: - Player began
    
    // first choice
    
    func testGivenPlayerBeganAndFirstChoiceIsCenterWhenAiHasToPlayThenItChoosedCorner() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .player)
        choose(.box11, viewModel: gridViewModel)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCorner)
    }
    func testGivenPlayerBeganAndFirstChoiceIsCornerWhenAiHasToPlayThenItChoosedCenter() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .player)
        choose(.box00, viewModel: gridViewModel)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCenter)
    }
    func testGivenPlayerBeganAndFirstChoiceIsMiddleCornerWhenAiHasToPlayThenItChoosedCenter() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .player)
        choose(.box01, viewModel: gridViewModel)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCenter)
    }
    
    // second choice
    
    func testGivenPlayerBeganAndFirstChoiceIsCenterSecondIsCornerWhenAiHasToPlayThenItChoosedAnotherCorner() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .player)
        choose(.box11, viewModel: gridViewModel)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        let boxToPlay = GridBox.allCases.compactMap({ $0.isCorner && $0.owner == .none ? $0 : nil })[0]
        choose(boxToPlay, viewModel: gridViewModel)
        let box2 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isCorner)
    }
    func testGivenPlayerBeganAndFirstChoiceIsCenterSecondIsMiddleCornerWhenAiHasToPlayThenItChoosedTheOppositeMiddleCorner() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .player)
        choose(.box11, viewModel: gridViewModel)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        let boxToPlay = GridBox.allCases.compactMap({ $0.isMiddleCorner && $0.owner == .none ? $0 : nil })[0]
        choose(boxToPlay, viewModel: gridViewModel)
        let box2 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCorner)
        XCTAssert(box2.isMiddleCorner)
        XCTAssert(boxToPlay.oppositeBox == box2)
    }
    func testGivenPlayerBeganAndFirstChoiceIsCornerSecondIsCornerWhenAiHasToPlayThenItChoosedMiddleCorner() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .player)
        choose(.box00, viewModel: gridViewModel)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        let boxToPlay = GridBox.allCases.compactMap({ $0.isCorner && $0.owner == .none ? $0 : nil })[0]
        choose(boxToPlay, viewModel: gridViewModel)
        let box2 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCenter)
        XCTAssert(box2.isMiddleCorner)
    }
    func testGivenPlayerBeganAndFirstChoiceIsCornerSecondIsMiddleCornerWhenAiHasToPlayThenItChoosedACorner() throws {
        let aiViewModel = AIViewModel()
        let gridViewModel = GridViewModel(beginner: .player)
        choose(.box00, viewModel: gridViewModel)
        let box1 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        let boxToPlay = GridBox.allCases.compactMap({ $0.isMiddleCorner && $0.owner == .none ? $0 : nil })[0]
        choose(boxToPlay, viewModel: gridViewModel)
        let box2 = try aiPlays(aiViewModel: aiViewModel, gridViewModel: gridViewModel)
        XCTAssert(box1.isCenter)
        XCTAssert(box2.isCorner)
    }
    
    
    
    // MARK: - Supporting methods
    
    private func choose(_ box: GridBox, viewModel: GridViewModel) {
        viewModel.boxButtonHasBeenHitten(box)
        viewModel.playerDidChoose(box)
        viewModel.nextPlayer()
    }
    @discardableResult
    private func aiPlays(aiViewModel: AIViewModel, gridViewModel: GridViewModel) throws -> GridBox {
        gridViewModel.aiIsPlaying()
        aiViewModel.play()
        let decision = try XCTUnwrap(aiViewModel.decision)
        aiViewModel.reset()
        choose(decision, viewModel: gridViewModel)
        return decision
    }
    

}
