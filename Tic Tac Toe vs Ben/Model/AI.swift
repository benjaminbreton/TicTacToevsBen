//
//  AI.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
struct AI {
    
    // MARK: - Setted properties
    
    /// The made decision.
    private(set) var decision: GridBox? = nil
    /// The current grid.
    private var grid: [[Player]] = []
    
    // MARK: - Computed properties
    
    /// All decisions made by the AI during this game.
    private var allDecisions: [GridBox] {
        var decisions: [GridBox] = []
        for index1 in 0..<grid.count {
            let row = grid[index1]
            for index2 in 0..<row.count {
                let player = row[index2]
                if player == .me {
                    decisions.append(GridBox.allBoxesMultipleArray[index1][index2])
                }
            }
        }
        return decisions
    }
    
    private var occupiedBoxes: Int { grid.map({ $0.map({ $0.int == 0 ? 0 : 1 }).reduce(0, +) }).reduce(0, +) }
    private var hasBegun: Bool {
        occupiedBoxes.isMultiple(of: 2)
    }
    
    
    private var freeCorners: [GridBox] {
        freeBoxes.compactMap({ $0.isCorner ? $0 : nil })
    }
    private var freeBoxes: [GridBox] {
        var freeBoxes: [GridBox] = []
        for index1 in 0..<grid.count {
            let row = grid[index1]
            for index2 in 0..<row.count {
                let player = row[index2]
                if player == .none {
                    freeBoxes.append(GridBox.allBoxesMultipleArray[index1][index2])
                }
            }
        }
        return freeBoxes
    }
    
    private var playerDecisions: [GridBox] {
        var playerDecisions: [GridBox] = []
        for index1 in 0..<grid.count {
            let row = grid[index1]
            for index2 in 0..<row.count {
                let player = row[index2]
                if player == .player {
                    playerDecisions.append(GridBox.allBoxesMultipleArray[index1][index2])
                }
            }
        }
        return playerDecisions
    }
    
    // MARK: - Decision

    mutating func decide(grid: [[Player]]) {
        self.grid = grid
        // check if AI can win with 1 move and eventually use it
        if let victoriousBox = searchForVictoriousBox(for: .me) {
            self.decision = victoriousBox
        // check if player can win with 1 move and eventually impeach it
        } else if let victoriousBox = searchForVictoriousBox(for: .player) {
            self.decision = victoriousBox
        // check if AI can win with 2 moves and eventually plan it
        } else if let winningChoice = getWinningChoice() {
            self.decision = winningChoice
        /*
             If previous cases failed, a decision has to be made based on which player began, and moves already done
             */
        } else if hasBegun {
            self.decision = getBoxWhenAIBegun()
        } else {
            self.decision = getBoxWhenIDidntBegin()
        }
    }
    
    // MARK: - Win with 1 move
    
    /**
     Check if a player can win with one move, and eventually returns the move to be done.
     - parameter player: The player.
     - returns: The move.
     */
    private func searchForVictoriousBox(for player: Player) -> GridBox? {
        for index in 0..<3 {
            if let victoriousBox = searchForVictoriousBox(for: player, index1: [index, index, index]) {
                return victoriousBox
            }
            if let victoriousBox = searchForVictoriousBox(for: player, index2: [index, index, index]) {
                return victoriousBox
            }
        }
        if let victoriousBox = searchForVictoriousBox(for: player, index1: [0, 1, 2], index2: [0, 1, 2]) {
            return victoriousBox
        }
        if let victoriousBox = searchForVictoriousBox(for: player, index1: [0, 1, 2], index2: [2, 1, 0]) {
            return victoriousBox
        }
        return nil
    }
    private func searchForVictoriousBox(for player: Player, index1: [Int] = [0, 1, 2], index2: [Int] = [0, 1, 2]) -> GridBox? {
        let line = [0, 1, 2].map({ grid[index1[$0]][index2[$0]] })
        if line.map({ $0 == player ? 1 : 0 }).reduce(0, +) == 2 {
            for index in 0..<3 {
                if line[index] == .none {
                    return GridBox.allBoxesMultipleArray[index1[index]][index2[index]]
                }
            }
        }
        return nil
    }
    
    // MARK: - AI begun
    
    private func getBoxWhenAIBegun() -> GridBox {
        var choices: [GridBox] = []
        if occupiedBoxes == 0 {
            // first choice : a corner
            choices = [
                .boxA1,
                .boxA3,
                .boxC1,
                .boxC3
            ]
        } else if occupiedBoxes == 2 {
            if playerDecisions[0].isMiddle {
                choices = [getDecisionInverse(allDecisions[0])]
            } else if playerDecisions[0].isMiddleCorner {
                choices = [.boxB2]
            } else {
                choices = freeCorners
            }
        } else {
            choices = freeBoxes
        }
        return choices[Int.random(in: 0..<choices.count)]
    }
    private func getBoxWhenIDidntBegin() -> GridBox {
        var choices: [GridBox] = []
        if occupiedBoxes == 1 {
            if playerDecisions[0].isMiddle {
                choices = [
                    .boxA1,
                    .boxA3,
                    .boxC1,
                    .boxC3
                ]
            } else {
                choices = [.boxB2]
            }
        } else if occupiedBoxes == 3 {
            if playerDecisions[0].isCorner {
                if playerDecisions[1].isCorner {
                    choices = [
                        .boxA2,
                        .boxB1,
                        .boxB3,
                        .boxC2
                    ]
                } else if playerDecisions[1].isMiddle {
                    choices = freeCorners
                } else {
                    choices = freeBoxes
                }
            } else if playerDecisions[0].isMiddle {
                if playerDecisions[1].isCorner {
                    choices = freeCorners
                } else {
                    choices = freeBoxes
                }
            } else {
                choices = freeBoxes
            }
        } else {
            choices = freeBoxes
        }
        return choices[Int.random(in: 0..<choices.count)]
    }
    
    // MARK: - Win with 2 moves
    
    private func getWinningChoice() -> GridBox? {
        for gridBox in freeBoxes {
            if isWinningChoice(gridBox) { return gridBox }
        }
        return nil
    }
    private func isWinningChoice(_ gridBox: GridBox) -> Bool {
        let rowValue = getValueOfLine(grid[gridBox.firstIndex]) + 1
        let colValue = getValueOfLine([0, 1, 2].map({ grid[$0][gridBox.secondIndex] })) + 1
        let diag1Value: Int
        let diag2Value: Int
        if gridBox.isMiddleCorner {
            diag1Value = 0
            diag2Value = 0
        } else {
            if (gridBox.isMiddle) || (gridBox.firstIndex == gridBox.secondIndex) {
                diag1Value = getValueOfLine([grid[0][0], grid[1][1], grid[2][2]]) + 1
            } else {
                diag1Value = 0
            }
            if (gridBox.isMiddle) || (gridBox.firstIndex != gridBox.secondIndex) {
                diag2Value = getValueOfLine([grid[0][2], grid[1][1], grid[2][0]]) + 1
            } else {
                diag2Value = 0
            }
        }
        if rowValue == 2 {
            if colValue == 2 || diag1Value == 2 || diag2Value == 2 {
                return true
            }
        } else if colValue == 2 {
            if diag1Value == 2 || diag2Value == 2 {
                return true
            }
        } else if diag1Value == 2 && diag2Value == 2 {
            return true
        }
        return false
    }
    private func getValueOfLine(_ line: [Player]) -> Int {
        guard line.map({ $0 == .player ? 1 : 0 }).reduce(0, +) == 0 else { return 0 }
        return line.map({ $0 == .me ? 1 : 0 }).reduce(0, +)
    }
    mutating func reset() {
        decision = nil
    }
    private func getDecisionInverse(_ decision: GridBox) -> GridBox {
        GridBox.getBox(row: getRowInverse(decision.row), col: getColInverse(decision.col))
    }
    private func getColInverse(_ col: Int) -> Int {
        switch col {
        case 1:
            return 3
        case 3:
            return 1
        default:
            return 2
        }
    }
    private func getRowInverse(_ row: String) -> String {
        switch row {
        case "A":
            return "C"
        case "C":
            return "A"
        default:
            return "B"
        }
    }
}


