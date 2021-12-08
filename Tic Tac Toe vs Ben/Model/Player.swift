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
    var text: String {
        switch self {
        case .me:
            return "à moi"
        case .player:
            return "à vous"
        case .none:
            return ""
        }
    }
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
