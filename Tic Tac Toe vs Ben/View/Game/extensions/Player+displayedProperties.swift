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
        case .ai:
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
        case .ai:
            return "j'ai gagné, désolé..."
        default:
            return "vous avez gagné ! Bravo !"
        }
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
