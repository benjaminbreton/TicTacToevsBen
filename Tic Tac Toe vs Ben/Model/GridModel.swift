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
    
    @UserDefault("boxA1", defaultValue: 0)
    private var boxA1: Int
    @UserDefault("boxA2", defaultValue: 0)
    private var boxA2: Int
    @UserDefault("boxA3", defaultValue: 0)
    private var boxA3: Int
    @UserDefault("boxB1", defaultValue: 0)
    private var boxB1: Int
    @UserDefault("boxB2", defaultValue: 0)
    private var boxB2: Int
    @UserDefault("boxB3", defaultValue: 0)
    private var boxB3: Int
    @UserDefault("boxC1", defaultValue: 0)
    private var boxC1: Int
    @UserDefault("boxC2", defaultValue: 0)
    private var boxC2: Int
    @UserDefault("boxC3", defaultValue: 0)
    private var boxC3: Int
    @UserDefault("beginner", defaultValue: 2)
    private var beginner: Int
    @UserDefault("currentPlayer", defaultValue: 2)
    private var currentPlayerInt: Int
    
    private(set) var victoriousPlayer: Player? = nil
    private(set) var victoriousLine: GridLine? = nil
    
    var currentPlayer: Player { Player.getFromInt(currentPlayerInt) }
    var grid: [[Player]] { rowsInt.map({ $0.map( { Player.getFromInt($0)} ) }) }
    
    private var rowsInt: [[Int]] { [[boxA1, boxA2, boxA3], [boxB1, boxB2, boxB3], [boxC1, boxC2, boxC3]] }
    private var colsInt: [[Int]] { [[boxA1, boxB1, boxC1], [boxA2, boxB2, boxC2], [boxA3, boxB3, boxC3]] }
    private var diagInt: [[Int]] { [[boxA1, boxB2, boxC3], [boxA3, boxB2, boxC1]] }
    
    var canContinue: Bool {
        rowsInt.map({ $0.map({ $0 == 0 ? 1 : 0 }).reduce(0, +) }).reduce(0, +) > 0
    }
    
    private(set) var hasToWait: Bool = false
    
    init() {
        if let player = getVictoriousPlayer() {
            self.victoriousPlayer = player
        }
    }
    
    
    
    mutating func reset() {
        boxA1 = 0
        boxA2 = 0
        boxA3 = 0
        boxB1 = 0
        boxB2 = 0
        boxB3 = 0
        boxC1 = 0
        boxC2 = 0
        boxC3 = 0
        beginner = Player.getFromInt(beginner).switchPlayer.int
        currentPlayerInt = beginner
        victoriousPlayer = nil
        victoriousLine = nil
        hasToWait = false
    }
    
    mutating func playerDidChoose(row: String, col: Int) {
        guard row == "A" || row == "B" || row == "C" else { return }
        guard col > 0, col < 4 else { return }
        if row == "A" {
            if col == 1 {
                boxA1 = currentPlayerInt
            } else if col == 2 {
                boxA2 = currentPlayerInt
            } else if col == 3 {
                boxA3 = currentPlayerInt
            }
        } else if row == "B" {
            if col == 1 {
                boxB1 = currentPlayerInt
            } else if col == 2 {
                boxB2 = currentPlayerInt
            } else if col == 3 {
                boxB3 = currentPlayerInt
            }
        } else if row == "C" {
            if col == 1 {
                boxC1 = currentPlayerInt
            } else if col == 2 {
                boxC2 = currentPlayerInt
            } else if col == 3 {
                boxC3 = currentPlayerInt
            }
        }
        hasToWait = true
    }
    mutating func nextPlayer() {
        if let victoriousPlayer = getVictoriousPlayer() {
            self.victoriousPlayer = victoriousPlayer
            self.currentPlayerInt = 0
            return
        }
        if canContinue {
            currentPlayerInt = currentPlayer.switchPlayer.int
        } else {
            currentPlayerInt = 0
        }
        hasToWait = false
    }
    mutating private func getVictoriousPlayer() -> Player? {
        let players: [Player] = [.me, .player]
        for player in players {
            for line in GridLine.allCases {
                if line.gridBoxes.map({ grid[$0.rowsIndex][$0.colsIndex] == player ? 1 : 0 }).reduce(0, +) == 3 {
                    self.victoriousLine = line
                    return player
                }
            }
        }
        
//        let arrays: [[[Int]]] = [rowsInt, colsInt, diagInt]
//        for player in players {
//            for index in 0..<arrays.count {
//                if arrays[index].map({ $0.map({ $0 == player.int ? 1 : 0 }).reduce(0, +) == 3 ? 1 : 0 }).reduce(0, +) > 0 {
//                    return player
//                }
//            }
//        }
        return nil
    }
    mutating func forceWaiting() {
        self.hasToWait = true
    }
    

}



