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
    var text: String {
        switch self {
        case .player:
            return "player_turn".localized
        default:
            return "ai_turn".localized
        }
    }
    /// Text to display when the player is victorious.
    var winMessage: String {
        guard self == .ai else { return "player_victory".localized }
        return "ai_victory".localized
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
