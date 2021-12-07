//
//  GridModel.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
struct GridModel {
    @UserDefault("caseA1", defaultValue: 0)
    private var caseA1: Int
    @UserDefault("caseA2", defaultValue: 0)
    private var caseA2: Int
    @UserDefault("caseA3", defaultValue: 0)
    private var caseA3: Int
    @UserDefault("caseB1", defaultValue: 0)
    private var caseB1: Int
    @UserDefault("caseB2", defaultValue: 0)
    private var caseB2: Int
    @UserDefault("caseB3", defaultValue: 0)
    private var caseB3: Int
    @UserDefault("caseC1", defaultValue: 0)
    private var caseC1: Int
    @UserDefault("caseC2", defaultValue: 0)
    private var caseC2: Int
    @UserDefault("caseC3", defaultValue: 0)
    private var caseC3: Int
    @UserDefault("beginner", defaultValue: 2)
    private var beginner: Int
    @UserDefault("currentPlayer", defaultValue: 2)
    private var currentPlayerInt: Int
    
    var victoriousPlayer: Player? = nil
    
    var currentPlayer: Player { Player.getFromInt(currentPlayerInt) }
    var grid: [[Player]] { rowsInt.map({ $0.map( { Player.getFromInt($0)} ) }) }
    
    private var rowsInt: [[Int]] { [[caseA1, caseA2, caseA3], [caseB1, caseB2, caseB3], [caseC1, caseC2, caseC3]] }
    private var colsInt: [[Int]] { [[caseA1, caseB1, caseC1], [caseA2, caseB2, caseC2], [caseA3, caseB3, caseC3]] }
    private var diagInt: [[Int]] { [[caseA1, caseB2, caseC3], [caseA3, caseB2, caseC1]] }
    
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
        caseA1 = 0
        caseA2 = 0
        caseA3 = 0
        caseB1 = 0
        caseB2 = 0
        caseB3 = 0
        caseC1 = 0
        caseC2 = 0
        caseC3 = 0
        beginner = Player.getFromInt(beginner).switchPlayer.int
        currentPlayerInt = beginner
        victoriousPlayer = nil
        hasToWait = false
    }
    
    mutating func playerDidChoose(row: String, col: Int) {
        guard row == "A" || row == "B" || row == "C" else { return }
        guard col > 0, col < 4 else { return }
        if row == "A" {
            if col == 1 {
                caseA1 = currentPlayerInt
            } else if col == 2 {
                caseA2 = currentPlayerInt
            } else if col == 3 {
                caseA3 = currentPlayerInt
            }
        } else if row == "B" {
            if col == 1 {
                caseB1 = currentPlayerInt
            } else if col == 2 {
                caseB2 = currentPlayerInt
            } else if col == 3 {
                caseB3 = currentPlayerInt
            }
        } else if row == "C" {
            if col == 1 {
                caseC1 = currentPlayerInt
            } else if col == 2 {
                caseC2 = currentPlayerInt
            } else if col == 3 {
                caseC3 = currentPlayerInt
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
        }
        hasToWait = false
    }
    private func getVictoriousPlayer() -> Player? {
        let players: [Player] = [.me, .player]
        let arrays: [[[Int]]] = [rowsInt, colsInt, diagInt]
        for player in players {
            for index in 0..<arrays.count {
                if arrays[index].map({ $0.map({ $0 == player.int ? 1 : 0 }).reduce(0, +) == 3 ? 1 : 0 }).reduce(0, +) > 0 {
                    return player
                }
            }
        }
        return nil
    }
    mutating func forceWaiting() {
        self.hasToWait = true
    }
    

}



