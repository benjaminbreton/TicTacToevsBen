//
//  Player+displayedProperties.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 10/12/2021.
//

import SwiftUI

extension Player {
    // MARK: - Displayed properties
    
    /// Text to display when the player has top play.
    var turnCode: String {
        switch self {
        case .player:
            return "player_turn"
        default:
            return "ai_turn"
        }
    }
    /// Text to display when the player is victorious.
    var winMessageCode: String {
        guard self == .ai else { return "player_victory" }
        return "ai_victory"
    }
    /// The symbol to display in a box.
    var symbol: SymbolView {
        SymbolView(self)
    }
    /// The player's color's name.
    var color: Color {
        switch self {
        case .ai:
            return .appRed
        case .player:
            return .appGreen
        case .none:
            return .appBlack
        }
    }
}
