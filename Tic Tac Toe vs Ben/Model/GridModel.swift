//
//  GridModel.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
struct GridModel {
    /*
     The grid:
     
     Rows / Cols | 1 | 2 | 3 |
     ____________|___|___|___|
     A           |   |   |   |
     ____________|___|___|___|
     B           |   |   |   |
     ____________|___|___|___|
     C           |   |   |   |
     ____________|___|___|___|
     
     */
    
    // MARK: - Saved properties
    
    @UserDefault("beginner", defaultValue: 2)
    private var beginner: Int
    @UserDefault("currentPlayer", defaultValue: 2)
    private var currentPlayerInt: Int
    
    // MARK: - Setted properties
    
    /// The victorious player.
    private(set) var victoriousPlayer: Player? = nil
    /// The line made by the victorious player.
    private(set) var victoriousLine: GridLine? = nil
    /// Boolean indicating whether the player has to wait before choosing a box, or not.
    private(set) var hasToWait: Bool = false
    
    // MARK: - Computed properties
    
    /// The current player.
    var currentPlayer: Player { Player.getFromInt(currentPlayerInt) }
    /// The grid to display.
    var grid: [[GridBox]] {
        [
            GridLine.hTop.gridBoxes,
            GridLine.hCenter.gridBoxes,
            GridLine.hBottom.gridBoxes
        ]
    }
    /// Boolean indicating whether the round can continue or not, regarding the remaining free boxes in the grid.
    var canContinue: Bool {
        grid.map({ $0.map({ $0.owner == .none ? 1 : 0 }).reduce(0, +) }).reduce(0, +) > 0
    }
    
    // MARK: - Init
    
    init() {
        if let player = getVictoriousPlayer() {
            self.victoriousPlayer = player
        }
    }
    
    // MARK: - Reset
    
    /**
     Reset all properties to begin a new round.
     */
    mutating func reset() {
        for var box in GridBox.allCases {
            box.owner = .none
        }
        beginner = Player.getFromInt(beginner).switchPlayer.int
        currentPlayerInt = beginner
        victoriousPlayer = nil
        victoriousLine = nil
        hasToWait = false
    }
    
    // MARK: - Player did choose
    
    /**
     Performs actions regarding the box choosed by the player.
     */
    mutating func playerDidChoose(_ gridBox: GridBox) {
        var box = gridBox
        box.owner = currentPlayer
        hasToWait = true
    }
    
    // MARK: - Next player
    
    /**
     Verify victory conditions and prepare the game for the next move.
     */
    mutating func nextPlayer() {
        // check if a player won
        if let victoriousPlayer = getVictoriousPlayer() {
            self.victoriousPlayer = victoriousPlayer
            self.currentPlayerInt = 0
            return
        }
        // otherwise check if the round can continue
        if canContinue {
            currentPlayerInt = currentPlayer.switchPlayer.int
        } else {
            currentPlayerInt = 0
        }
        hasToWait = false
    }
    /**
     Verify if a player won and eventually returns it.
     - returns: The victorious player.
     */
    mutating private func getVictoriousPlayer() -> Player? {
        let players: [Player] = [.me, .player]
        for player in players {
            for line in GridLine.allCases {
                if line.gridBoxes.map({ $0.owner == player ? 1 : 0 }).reduce(0, +) == 3 {
                    self.victoriousLine = line
                    return player
                }
            }
        }
        return nil
    }
    
    // MARK: - Force waiting
    
    /**
     Force the player to wait before the next move.
     */
    mutating func forceWaiting() {
        self.hasToWait = true
    }
    
    
}



