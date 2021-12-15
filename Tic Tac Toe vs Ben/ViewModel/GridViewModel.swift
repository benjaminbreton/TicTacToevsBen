//
//  GridViewModel.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
final class GridViewModel: ObservableObject {
    
    // MARK: - Published properties
    
    @Published private var model: GridModel
    @Published private(set) var aiHasToPlay: Bool
    
    // MARK: - Computed properties
    
    var grid: [[GridBox]] { model.grid }
    var canContinue: Bool { model.canContinue }
    var currentPlayer: Player { model.currentPlayer }
    var victoriousPlayer: Player? { model.victoriousPlayer }
    var victoriousLine: GridLine? { model.victoriousLine }
    var hasToWait: Bool { model.hasToWait }
    var resetButtonHasBeenHitten: Bool { model.resetButtonHasBeenHitten }
    var boxHasBeenChoosen: Bool { model.boxHasBeenChoosen }
    
    // MARK: - Init
    
    init(beginner: Player? = nil) {
        self.model = GridModel(beginner: beginner)
        aiHasToPlay = false
        if model.currentPlayer == .ai {
            aiHasToPlay = true
        }
    }
    
    // MARK: - Choosen box
    
    /**
     Notify the fact that a box has been choosed to impeach another box to be choosen.
     - parameter box: The hitten box.
     */
    func boxButtonHasBeenHitten(_ box: GridBox) {
        model.boxButtonHasBeenHitten(box)
    }
    /**
     Ask model to change the value of a box that has been hitten.
     - parameter box: The hitten box.
     */
    func playerDidChoose(_ box: GridBox) {
        model.playerDidChoose(box)
    }
    /**
     After a box has been choosen, ask model to change the current player's value.
     */
    func nextPlayer() {
        model.nextPlayer()
        if currentPlayer == .ai {
            aiHasToPlay = true
        }
    }
    
    // MARK: - Reset
    
    /**
     Ask model to reset the grid values.
     */
    func reset() {
        model.reset()
    }
    
    // MARK: - AI is playing
    
    /**
     AI is playing, so turn off the property used to notify it has to play.
     */
    func aiIsPlaying() {
        aiHasToPlay = false
    }
    
}
