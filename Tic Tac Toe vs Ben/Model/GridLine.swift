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
    var addToXMultiplier: Bool {
        return self != .dLeftTopToRightBottom && self != .dLeftBottomToRightTop
    }
    var startMultipliers: (x: Float, y: Float) {
        (x: xMultiplier(for: gridCols[0]), y: yMultiplier(for: gridRows[0]))
    }
    var endMultipliers: (x: Float, y: Float) {
        (x: xMultiplier(for: gridCols[2]), y: yMultiplier(for: gridRows[2]))
    }
    private func xMultiplier(for col: Int) -> Float {
        let index: Float = Float(col)
        return getMultiplier(from: index)
    }
    private func yMultiplier(for row: Int) -> Float {
        let index: Float = Float(row)
        return getMultiplier(from: index)
    }
    private func getMultiplier(from index: Float) -> Float {
        let space: Float = 100 / 82
        let cellMiddle: Float = 100 / 82 * 80 / 3 / 2
        return cellMiddle + cellMiddle * 2 * index + space * index
    }
    var gridBoxes: [GridBox] {
        [0, 1, 2].map({ GridBox.getBox(row: gridRows[$0], col: gridCols[$0]) })
    }
}
