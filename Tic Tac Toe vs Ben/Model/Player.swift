//
//  Player.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
enum Player: CaseIterable {
    
    // MARK: - Cases
    
    case me, player, none
    
    // MARK: - Properties for saving
    
    /// Int reprensenting the case.
    var int: Int {
        switch self {
        case .me:
            return 1
        case .player:
            return 2
        case .none:
            return 0
        }
    }
    
    // MARK: - Displayed properties
    
    /// Text to display when the player has top play.
    var text: String {
        switch self {
        case .me:
            return "à moi"
        case .player:
            return "à toi"
        case .none:
            return ""
        }
    }
    /// Text to display when the player is victorious.
    var winMessage: String {
        switch self {
        case .me:
            return "j'ai gagné, désolé..."
        default:
            return "vous avez gagné ! Bravo !"
        }
    }
    /// Box first rotation when it has been hitten.
    var rotation90: Double {
        switch self {
        case .me:
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
        case .me:
            return -180
        case .player:
            return 180
        case .none:
            return 0
        }
    }
    /// The symbol to display in a box.
    var symbol: String {
        switch self {
        case .me:
            return "x"
        case .player:
            return "o"
        case .none:
            return ""
        }
    }
    /// The player's color's name.
    var colorName: String {
        switch self {
        case .me:
            return "AppRed"
        case .player:
            return "AppGreen"
        case .none:
            return "AppBlack"
        }
    }
    
    // MARK: - Game properties
    
    /// The new player replacing the previous.
    var switchPlayer: Player {
        switch self {
        case .player:
            return .me
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
