//
//  Player.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
enum Player: CaseIterable {
    
    // MARK: - Cases
    
    case ai, player, none
    
    // MARK: - Properties for saving
    
    /// Int reprensenting the case.
    var int: Int {
        switch self {
        case .ai:
            return 1
        case .player:
            return 2
        case .none:
            return 0
        }
    }
    
    // MARK: - Rotation values
    
    /// Box first rotation when it has been hitten.
    var rotation90: Double {
        switch self {
        case .ai:
            return -90
        default:
            return 90
        }
    }
    /// Box second rotation when it has been hitten.
    var rotation180: Double {
        switch self {
        case .ai:
            return -180
        default:
            return 180
        }
    }
    
    // MARK: - Game properties
    
    /// The new player replacing the previous.
    var switchPlayer: Player {
        switch self {
        case .player:
            return .ai
        default:
            return .player
        }
    }
    
    var allDecisions: [GridBox] {
        var decisions: [[GridBox]] = []
        decisions.append(GridBox.box11.owner == self ? [GridBox.box11] : [])
        decisions.append(GridBox.allCases.compactMap({ $0.isCorner && $0.owner == self ? $0 : nil }))
        decisions.append(GridBox.allCases.compactMap({ $0.isMiddleCorner && $0.owner == self ? $0 : nil }))
        return decisions.flatMap({ $0 })
    }
    
    // MARK: - Get player
    
    /**
     Get a player using the Int.
     - parameter int: The player's int.
     - returns: The Player.
     */
    static func getFromInt(_ int: Int) -> Player {
        let result = allCases.compactMap({ $0.int == int ? $0 : nil })
        guard result.count == 1 else { return .none }
        return result[0]
    }
}
