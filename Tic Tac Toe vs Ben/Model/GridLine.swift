//
//  GridLine.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import Foundation
enum GridLine: CaseIterable {
    case hTop, hCenter, hBottom, vLeft, vCenter, vRight, dLeftTopToRightBottom, dLeftBottomToRightTop
    var gridRows: [Int] {
        switch self {
        case .hTop:
            return Array(repeating: 0, count: 3)
        case .hCenter:
            return Array(repeating: 1, count: 3)
        case .hBottom:
            return Array(repeating: 2, count: 3)
        case .dLeftBottomToRightTop:
            return [2, 1, 0]
        default:
            return [0, 1, 2]
        }
    }
    var gridCols: [Int] {
        switch self {
        case .vLeft:
            return Array(repeating: 0, count: 3)
        case .vCenter:
            return Array(repeating: 1, count: 3)
        case .vRight:
            return Array(repeating: 2, count: 3)
        default:
            return [0, 1, 2]
        
        }
    }
    
    var gridBoxes: [GridBox] {
        [0, 1, 2].map({ GridBox.getBox(row: gridRows[$0], col: gridCols[$0]) })
    }
}
