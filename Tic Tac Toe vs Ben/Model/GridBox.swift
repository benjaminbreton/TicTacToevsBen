//
//  GridBox.swift
//  Tic Tac Toe vs Ben
//
//  Created by Benjamin Breton on 08/12/2021.
//

import Foundation
enum GridBox: CaseIterable {
    /*
     The grid:
     
     Rows / Cols | 1 | 2 | 3 |
     ____________|___|___|___|
     A           |   |   |   |
     ____________|___|___|___|
     B           |   |   |   |
     ____________|___|___|___|
     C           |   |   |   |
     ____________|___|___|___|
     
     */
    case boxA1, boxA2, boxA3, boxB1, boxB2, boxB3, boxC1, boxC2, boxC3
    /// Rows of the grid.
    private var rows: [String] { ["A", "B", "C"] }
    /// The row's index in the grid for the box.
    var rowsIndex: Int {
        switch self {
        case .boxA1, .boxA2, .boxA3:
            return 0
        case .boxB1, .boxB2, .boxB3:
            return 1
        case .boxC1, .boxC2, .boxC3:
            return 2
        }
    }
    /// The col's index in the grid for the box.
    var colsIndex: Int {
        switch self {
        case .boxA1, .boxB1, .boxC1:
            return 0
        case .boxA2, .boxB2, .boxC2:
            return 1
        case .boxA3, .boxB3, .boxC3:
            return 2
        }
    }
    /// Boolean indicating whether the box is situated in the middle of two corners (except the center box), or not.
    var isMiddleCorner: Bool { (rowsIndex == 1 || colsIndex == 1) && (rowsIndex != colsIndex) }
    /// Boolean indicating whether the box is situated on the grid's center or not.
    var isCenter: Bool { self == .boxB2 }
    /// Boolean indicating whether the box is situated on a grid's corner or not.
    var isCorner: Bool { (rowsIndex == 0 || rowsIndex == 2) && (colsIndex == 0 || colsIndex == 2) }
    /// The row's letter for the box.
    var row: String { rows[rowsIndex] }
    /// The col's number for the box
    var col: Int { colsIndex + 1 }
    /// Get the box situated at the opposite on the grid of this one.
    var oppositeBox: GridBox {
        let col = self.col == 1 ? 3 : self.col == 3 ? 1 : 2
        let row = self.row == "A" ? "C" : self.row == "C" ? "A" : "B"
        return GridBox.getBox(row: row, col: col)
    }
    /// All GridLines containing the GridBox.
    var gridLines: [GridLine] {
        GridLine.allCases.compactMap({ $0.gridBoxes.contains(self) ? $0 : nil })
    }
    /**
     Method returning a GridBox regarding its row's letter and col's number.
     - parameter row: The row's letter of the box.
     - parameter col: The col's number of the box.
     - returns: The GridBox.
     */
    static func getBox(row: String, col: Int) -> GridBox {
        let result = allCases.compactMap({ $0.row == row && $0.col == col ? $0 : nil})
        if result.count == 1 {
            return result[0]
        }
        return .boxA1
    }
    /// An array representing the grid and its GridBoxes.
    static var allBoxesMultipleArray: [[GridBox]] {
        [GridLine.hTop.gridBoxes,
         GridLine.hCenter.gridBoxes,
         GridLine.hBottom.gridBoxes]
    }
}
