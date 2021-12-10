//
//  GridViewModel.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
class GridViewModel: ObservableObject {
    @Published private var model: GridModel
    
    @Published private(set) var aiHasToPlay: Bool
    
    var grid: [[GridBox]] { model.grid }
    var canContinue: Bool { model.canContinue }
    var currentPlayer: Player { model.currentPlayer }
    var victoriousPlayer: Player? { model.victoriousPlayer }
    var victoriousLine: GridLine? { model.victoriousLine }
    var hasToWait: Bool { model.hasToWait }
    var resetButtonHasBeenHitten: Bool { model.resetButtonHasBeenHitten }
    var boxHasBeenChoosen: Bool { model.boxHasBeenChoosen }
    init(beginner: Player? = nil) {
        self.model = GridModel(beginner: beginner)
        aiHasToPlay = false
        if model.currentPlayer == .ai {
            aiHasToPlay = true
        }
        
    }
    
    func playerDidChoose(_ gridBox: GridBox) {
        model.playerDidChoose(gridBox)
    }
    
    func reset() {
        model.reset()
    }
    func boxButtonHasBeenHitten(_ box: GridBox) {
        model.boxButtonHasBeenHitten(box)
    }
    func nextPlayer() {
        model.nextPlayer()
        if currentPlayer == .ai {
            aiHasToPlay = true
        }
    }
    func aiIsPlaying() {
        aiHasToPlay = false
    }
    
}
