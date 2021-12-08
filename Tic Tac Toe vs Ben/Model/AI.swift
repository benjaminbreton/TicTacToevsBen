//
//  AI.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
struct AI {
    
    // MARK: - Setted properties
    
    private(set) var decision: GridCase? = nil
    private var allDecisions: [GridCase] {
        var decisions: [GridCase] = []
        for index1 in 0..<grid.count {
            let row = grid[index1]
            for index2 in 0..<row.count {
                let player = row[index2]
                if player == .me {
                    decisions.append(GridCase.allCasesMultipleArray[index1][index2])
                }
            }
        }
        return decisions
    }
    private var grid: [[Player]] = []
    
    // MARK: - Computed properties
    
    private var occupiedCases: Int { grid.map({ $0.map({ $0.int == 0 ? 0 : 1 }).reduce(0, +) }).reduce(0, +) }
    private var hasBegun: Bool {
        occupiedCases.isMultiple(of: 2)
    }
    private let rows = ["A", "B", "C"]
    private let cols = [1, 2, 3]
    
    private var freeCorners: [GridCase] {
        freeCases.compactMap({ $0.isCorner ? $0 : nil })
    }
    private var freeCases: [GridCase] {
        var freeCases: [GridCase] = []
        for index1 in 0..<grid.count {
            let row = grid[index1]
            for index2 in 0..<row.count {
                let player = row[index2]
                if player == .none {
                    freeCases.append(GridCase.allCasesMultipleArray[index1][index2])
                }
            }
        }
        return freeCases
    }
    
    private var playerDecisions: [GridCase] {
        var playerDecisions: [GridCase] = []
        for index1 in 0..<grid.count {
            let row = grid[index1]
            for index2 in 0..<row.count {
                let player = row[index2]
                if player == .player {
                    playerDecisions.append(GridCase.allCasesMultipleArray[index1][index2])
                }
            }
        }
        return playerDecisions
    }

    mutating func decide(grid: [[Player]]) {
        self.grid = grid
        if let victoriousCase = searchForVictoriousCase(for: .me) {
            self.decision = victoriousCase
        } else if let victoriousCase = searchForVictoriousCase(for: .player) {
            self.decision = victoriousCase
        } else if let winningChoice = getWinningChoice() {
            self.decision = winningChoice
        } else if hasBegun {
            self.decision = getCaseWhenIBegun()
        } else {
            self.decision = getCaseWhenIDidntBegin()
        }
    }
    private func searchForVictoriousCase(for player: Player) -> GridCase? {
        for index in 0..<3 {
            if let victoriousCase = searchForVictoriousCase(for: player, index1: [index, index, index]) {
                return victoriousCase
            }
            if let victoriousCase = searchForVictoriousCase(for: player, index2: [index, index, index]) {
                return victoriousCase
            }
        }
        if let victoriousCase = searchForVictoriousCase(for: player, index1: [0, 1, 2], index2: [0, 1, 2]) {
            return victoriousCase
        }
        if let victoriousCase = searchForVictoriousCase(for: player, index1: [0, 1, 2], index2: [2, 1, 0]) {
            return victoriousCase
        }
        return nil
    }
    private func searchForVictoriousCase(for player: Player, index1: [Int] = [0, 1, 2], index2: [Int] = [0, 1, 2]) -> GridCase? {
        let line = [0, 1, 2].map({ grid[index1[$0]][index2[$0]] })
        if line.map({ $0 == player ? 1 : 0 }).reduce(0, +) == 2 {
            for index in 0..<3 {
                if line[index] == .none {
                    return GridCase.allCasesMultipleArray[index1[index]][index2[index]]
                }
            }
        }
        return nil
    }
    private func getCaseWhenIBegun() -> GridCase {
        var choices: [GridCase] = []
        if occupiedCases == 0 {
            choices = [
                .caseA1,
                .caseA3,
                .caseC1,
                .caseC3
            ]
        } else if occupiedCases == 2 {
            if playerDecisions[0].isMiddle {
                choices = [getDecisionInverse(allDecisions[0])]
            } else if playerDecisions[0].isMiddleCorner {
                choices = [.caseB2]
            } else {
                choices = freeCorners
            }
        } else {
            choices = freeCases
        }
        return choices[Int.random(in: 0..<choices.count)]
    }
    private func getCaseWhenIDidntBegin() -> GridCase {
        var choices: [GridCase] = []
        if occupiedCases == 1 {
            if playerDecisions[0].isMiddle {
                choices = [
                    .caseA1,
                    .caseA3,
                    .caseC1,
                    .caseC3
                ]
            } else {
                choices = [.caseB2]
            }
        } else if occupiedCases == 2 {
            if playerDecisions[0].isCorner && playerDecisions[1].isCorner {
                choices = [
                    .caseA2,
                    .caseB1,
                    .caseB3,
                    .caseC2
                ]
            } else {
                choices = freeCases
            }
        } else {
            choices = freeCases
        }
        return choices[Int.random(in: 0..<choices.count)]
    }
    
    private func getWinningChoice() -> GridCase? {
        for gridCase in freeCases {
            if isWinningChoice(gridCase) { return gridCase }
        }
        return nil
    }
    private func isWinningChoice(_ gridCase: GridCase) -> Bool {
        let rowValue = getValueOfLine(grid[gridCase.firstIndex]) + 1
        let colValue = getValueOfLine([0, 1, 2].map({ grid[$0][gridCase.secondIndex] })) + 1
        let diag1Value: Int
        let diag2Value: Int
        if gridCase.isMiddleCorner {
            diag1Value = 0
            diag2Value = 0
        } else {
            if (gridCase.isMiddle) || (gridCase.firstIndex == gridCase.secondIndex) {
                diag1Value = getValueOfLine([grid[0][0], grid[1][1], grid[2][2]]) + 1
            } else {
                diag1Value = 0
            }
            if (gridCase.isMiddle) || (gridCase.firstIndex != gridCase.secondIndex) {
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
    private func getDecisionInverse(_ decision: GridCase) -> GridCase {
        GridCase.getCase(row: getRowInverse(decision.row), col: getColInverse(decision.col))
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


