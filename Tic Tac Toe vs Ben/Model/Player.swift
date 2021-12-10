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
        case .player:
            return 90
        case .none:
            return 0
        }
    }
    /// Box second rotation when it has been hitten.
    var rotation180: Double {
        switch self {
        case .ai:
            return -180
        case .player:
            return 180
        case .none:
            return 0
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
    
    // MARK: - Get player
    
    /**
     Get a player using the Int.
     - parameter int: The player's int.
     - returns: The Player.
     */
    static func getFromInt(_ int: Int) -> Player {
        let result = allCases.compactMap({ $0.int == int ? $0 : nil })
        if result.count == 1 {
            return result[0]
        }
        return .none
    }
}
