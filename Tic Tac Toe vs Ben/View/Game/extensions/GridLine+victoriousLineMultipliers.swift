//
//  GridLine+victoriousLineMultipliers.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 10/12/2021.
//

import SwiftUI

extension GridLine {
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
}
