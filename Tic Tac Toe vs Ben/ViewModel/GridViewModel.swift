//
//  GridViewModel.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
class GridViewModel: ObservableObject {
    @Published private var model: GridModel
    var grid: [[Player]] { model.grid }
    var canContinue: Bool { model.canContinue }
    var currentPlayer: Player { model.currentPlayer }
    var victoriousPlayer: Player? { model.victoriousPlayer }
    var hasToWait: Bool { model.hasToWait }
    init() {
        self.model = GridModel()
    }
    
    func playerDidChoose(row: String, col: Int) {
        model.playerDidChoose(row: row, col: col)
    }
    
    func reset() {
        model.reset()
    }
    func forceWaiting() {
        model.forceWaiting()
    }
    func nextPlayer() {
        model.nextPlayer()
    }
    
}
