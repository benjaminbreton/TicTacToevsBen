//
//  Player.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 07/12/2021.
//

import Foundation
enum Player: CaseIterable {
    case me, player, none
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
    var switchPlayer: Player {
        switch self {
        case .player:
            return .me
        default:
            return .player
        }
    }
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
    static func getFromInt(_ int: Int) -> Player {
        let result = allCases.compactMap({ $0.int == int ? $0 : nil })
        if result.count == 1 {
            return result[0]
        }
        return .none
    }
}
