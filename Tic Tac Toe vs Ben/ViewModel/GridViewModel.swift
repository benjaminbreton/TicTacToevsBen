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
    
    var gridMessage: String {
        if let player = victoriousPlayer {
            return player.winMessage
        } else if canContinue {
            return currentPlayer.text
        }
        return "match nul"
    }
    var gridColorName: String {
        if let player = victoriousPlayer {
            return player.colorName
        }
        return currentPlayer.colorName
    }
    init() {
        self.model = GridModel()
        aiHasToPlay = false
        if model.currentPlayer == .me {
            aiHasToPlay = true
        }
    }
    
    func playerDidChoose(_ gridBox: GridBox) {
        model.playerDidChoose(gridBox)
    }
    
    func reset() {
        model.reset()
    }
    func forceWaiting() {
        model.forceWaiting()
    }
    func nextPlayer() {
        model.nextPlayer()
        if currentPlayer == .me {
            aiHasToPlay = true
        }
    }
    func aiIsPlaying() {
        aiHasToPlay = false
    }
    
}
