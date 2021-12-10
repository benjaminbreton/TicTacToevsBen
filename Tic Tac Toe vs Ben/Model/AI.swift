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
    
    // MARK: - Decisions made
    
    /// All decisions made by the AI during this game.
    private var allDecisions: [GridBox] {
        GridBox.allCases.compactMap({ $0.owner == .ai ? $0 : nil })
    }
    /// Decisions made by the player.
    private var playerDecisions: [GridBox] {
        GridBox.allCases.compactMap({ $0.owner == .player ? $0 : nil })
    }
    
    // MARK: - Free boxes
    
    /// Free boxes in the current grid that are corners.
    private var freeCorners: [GridBox] {
        freeBoxes.compactMap({ $0.isCorner ? $0 : nil })
    }
    /// Free boxes in the current grid that are situated in the middle of two corners.
    private var freeMiddleCorners: [GridBox] {
        freeBoxes.compactMap({ $0.isMiddleCorner ? $0 : nil })
    }
    /// Free boxes in the grid.
    private var freeBoxes: [GridBox] {
        GridBox.allCases.compactMap({ $0.owner == .none ? $0 : nil })
    }
    
    // MARK: - Occupied boxes
    
    /// Number of occupied boxes in the current grid.
    private var occupiedBoxesCount: Int { 9 - freeBoxes.count }
    
    // MARK: - Has begun
    
    /// Boolean indicating whether the AI began or not
    private var hasBegun: Bool {
        occupiedBoxesCount.isMultiple(of: 2)
    }
    
    // MARK: - Decision
    
    /**
     Ask AI to make a decision regarding the current grid.
     - parameter grid: The current grid.
     */
    mutating func decide() {
        //self.grid = grid
        // check if AI can win with 1 move and eventually use it
        if let victoriousBox = searchForVictoriousBox(for: .ai) {
            self.decision = victoriousBox
        // check if player can win with 1 move and eventually impeach it
        } else if let victoriousBox = searchForVictoriousBox(for: .player) {
            self.decision = victoriousBox
        // check if AI can win with 2 moves and eventually plan it
        } else if let winningChoice = getBoxToWinWithTwoMoves() {
            self.decision = winningChoice
        /*
             If previous cases failed, a decision has to be made based on which player began, and moves already done
             */
        } else if hasBegun {
            self.decision = getBoxWhenAIBegun()
        } else {
            self.decision = getBoxWhenAIDidntBegin()
        }
    }
    
    // MARK: - Win with 1 move
    
    /**
     Check if a player can win with one move, and eventually returns the move to be done.
     - parameter player: The player.
     - returns: The move.
     */
    private func searchForVictoriousBox(for player: Player) -> GridBox? {
        for line in GridLine.allCases {
            if let box = searchForVictoriousBox(for: player, in: line) {
                return box
            }
        }
        return nil
    }
    private func searchForVictoriousBox(for player: Player, in line: GridLine) -> GridBox? {
        let lineDecisions = line.gridBoxes.map({ $0.owner })
        if lineDecisions.map({ $0 == player ? 1 : 0 }).reduce(0, +) == 2 {
            for index in 0..<3 {
                if lineDecisions[index] == .none {
                    return line.gridBoxes[index]
                }
            }
        }
        return nil
    }
    
    // MARK: - Win with 2 moves
    
    /**
     Search for a box which can give the AI the victory with two moves.
     - returns: Eventually, the box to play for the AI to win with two moves.
     */
    private func getBoxToWinWithTwoMoves() -> GridBox? {
        // check if each free box can give the AI the victory with two moves
        for gridBox in freeBoxes {
            if canGiveTheVictoryWithTwoMoves(gridBox) { return gridBox }
        }
        return nil
    }
    private func canGiveTheVictoryWithTwoMoves(_ gridBox: GridBox) -> Bool {
        /*
         To win with two moves, the AI has to choose a box with which he can get two lines. Then the player will have to choose one of them, the other will give AI the victory next round.
         In this method, AI will check all the lines containing the box entered in parameter to determinate if he can get two lines by playing this box.
         */
        let linesContainingTheBox = gridBox.gridLines
        let boxOwnedInTheLines = linesContainingTheBox.map({ $0.gridBoxes.map({ $0.owner == .ai ? 1 : $0.owner == .player ? -3 : 0 }).reduce(0, +) })
        // for each line, if the result is 1, the AI can get a line; otherwise, he can't
        let numberOfLines = boxOwnedInTheLines.map({ $0 == 1 ? 1 : 0 }).reduce(0, +)
        return numberOfLines > 1
    }
    
    // MARK: - AI began
    
    /**
     This method is called when there are no boxes which can give the victory to a player, and no boxes which can give victory to the AI with two moves. So this method will help AI to make a decision based on the existing moves.
     */
    private func getBoxWhenAIBegun() -> GridBox {
        var choices: [GridBox] = []
        if occupiedBoxesCount == 0 {
            // first choice : a corner
            choices = freeCorners
        } else if occupiedBoxesCount == 2 {
            // the second decisions depends on the decision made by the player
            if playerDecisions[0].isCenter {
                // if is middle, choose the opposite corner of the first
                choices = [allDecisions[0].oppositeBox]
            } else if playerDecisions[0].isCorner {
                // if is corner, choose another corner
                choices = freeCorners
            } else {
                // else, choose the center box
                choices = [.box11]
            }
        }
        // if no choice has been made, pick a free box
        if choices == [] {
            choices = freeBoxes
        }
        // returns a random box based on choices
        return choices[Int.random(in: 0..<choices.count)]
    }
    
    // MARK: - AI did'nt begin
    
    /**
     This method is called when there are no boxes which can give the victory to a player, and no boxes which can give victory to the AI with two moves. So this method will help AI to make a decision based on the existing moves.
     */
    private func getBoxWhenAIDidntBegin() -> GridBox {
        var choices: [GridBox] = []
        if occupiedBoxesCount == 1 {
            // the player has made his first move
            if playerDecisions[0].isCenter {
                // if it is center, choose a corner
                choices = freeCorners
            } else {
                // else, choose the center
                choices = [.box11]
            }
        } else if occupiedBoxesCount == 3 {
            // the player has made two moves
            if playerDecisions[0].isCorner {
                if playerDecisions[1].isCorner {
                    // if two corners have been chosen, choose a box situated between two corners
                    choices = freeMiddleCorners
                } else if playerDecisions[1].isCenter {
                    // if a corner and the center have been chosen, choose a corner
                    choices = freeCorners
                } else {
                    choices = [playerDecisions[0].oppositeBox]
                }
            } else if playerDecisions[0].isCenter {
                if playerDecisions[1].isCorner {
                    // if a corner and the center have been chosen, choose a corner
                    choices = freeCorners
                }
            }
        }
        // if no choice has been made, pick a free box
        if choices == [] {
            choices = freeBoxes
        }
        return choices[Int.random(in: 0..<choices.count)]
    }
    
    // MARK: - Reset
    
    mutating func reset() {
        decision = nil
    }
}


